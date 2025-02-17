import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/constants/constants.dart';
import '../../../../../core/constants/widget_sizes.dart';
import '../../../data/models/watchlist_model/watchlist_response.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_event.dart';
import '../../widgets/action_button.dart';
import '../../widgets/vertical_scroll_bar.dart';

class EditWatchlist extends StatefulWidget {
  const EditWatchlist({
    super.key,
    required this.watchlist,
  });

  final List<SymbolDetails> watchlist;

  @override
  State<EditWatchlist> createState() => _EditWatchlistState();
}

class _EditWatchlistState extends State<EditWatchlist> {
  late final WatchlistBloc bloc;
  late ValueNotifier<List<SymbolDetails>> symbolsNotifier;
  late List<bool> selected;
  late bool isModified = false;
  late bool isSymbolDeleted = false;
  late bool isSymbolRename = false;
  ValueNotifier<bool> withoutSaving = ValueNotifier<bool>(true);
  late final ValueNotifier<bool> isEditableNotifier = ValueNotifier(false);
  final ValueNotifier<ElevatedButtonState> buttonStateNotifier =
      ValueNotifier<ElevatedButtonState>(ElevatedButtonState.disable);
  Map<String, dynamic> reqData = {};
  List<SymbolDetails> deletedSymbols = [];
  final reorderIndexNotifier = ValueNotifier<int>(-1);
  final ValueNotifier<bool> showWatchErrorNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showWatchExistNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    super.initState();
    bloc = BlocProvider.of<WatchlistBloc>(context);
    symbolsNotifier = ValueNotifier(widget.watchlist);
    selected = List.generate(widget.watchlist.length, (index) => false);
  }

  @override
  void dispose() {
    isEditableNotifier.dispose();
    reorderIndexNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return ValueListenableBuilder<bool>(
        valueListenable: withoutSaving,
        builder: (context, withoutSavings, child) {
          return PopScope(
            canPop: withoutSavings,
            onPopInvokedWithResult: (bool didPop, Object? result) {
              if (didPop) {
                return;
              }
              withoutSavingBackPopUp(context);
            },
            child: Scaffold(
              appBar: AppBar(
                leadingWidth: WidgetSizes.s35,
                centerTitle: false,
                title: Text(
                  AppConstants.editWatchlist,
                  style: theme.textTheme.titleMedium!
                      .copyWith(color: colorScheme.onSurface),
                ),
              ),
              body: Column(
                children: [
                  Expanded(
                    child: ValueListenableBuilder<List<SymbolDetails>>(
                      valueListenable: symbolsNotifier,
                      builder: (context, symbols, _) {
                        return ReorderableListView.builder(
                          onReorderStart: (index) =>
                              reorderIndexNotifier.value = index,
                          onReorderEnd: (index) =>
                              reorderIndexNotifier.value = -1,
                          onReorder: (int oldIndex, int newIndex) {
                            final bloc =
                                BlocProvider.of<WatchlistBloc>(context);
                            bloc.add(
                              WatchlistReorderEvent(
                                oldIndex,
                                newIndex,
                                selected,
                              ),
                            );

                            isModified = true;
                            withoutSaving.value = false;
                            buttonStateNotifier.value =
                                ElevatedButtonState.active;
                          },
                          itemCount: symbols.length,
                          itemBuilder: (context, index) {
                            return ValueListenableBuilder(
                              key: ObjectKey(symbols[index]),
                              valueListenable: reorderIndexNotifier,
                              builder: (context, reorderIndex, child) {
                                return Material(
                                  color: reorderIndexNotifier.value == index
                                      ? colorScheme.onPrimary.withOpacity(0.95)
                                      : colorScheme.onPrimary,
                                  child: Column(
                                    children: [
                                      ListTile(
                                        contentPadding: const EdgeInsets.only(
                                          left: WidgetSizes.paddingMedium,
                                        ),
                                        leading: ReorderableDragStartListener(
                                          index: index,
                                          child: Icon(Icons.list),
                                        ),
                                        title: Text(
                                          symbols[index].dispSym!,
                                          style: theme.textTheme.bodySmall
                                              ?.copyWith(
                                            color: colorScheme.inverseSurface,
                                          ),
                                        ),
                                        subtitle: Text(
                                          symbols[index].exc!,
                                          style: theme.textTheme.labelSmall
                                              ?.copyWith(
                                            color: colorScheme.inverseSurface,
                                          ),
                                        ),
                                        trailing: IconButton(
                                          icon: Icon(Icons.delete),
                                          onPressed: () {
                                            _deleteSymbol(index, selected);
                                            isSymbolDeleted = true;
                                            withoutSaving.value = false;
                                            buttonStateNotifier.value =
                                                ElevatedButtonState.active;
                                          },
                                        ),
                                      ),
                                      if (index < symbols.length - 1)
                                        Divider(
                                          endIndent: WidgetSizes.paddingMedium,
                                          indent: WidgetSizes.paddingMedium,
                                          height: WidgetSizes.s1,
                                          thickness: 0.5,
                                          color: colorScheme.outlineVariant,
                                        ),
                                    ],
                                  ),
                                );
                              },
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: WidgetSizes.s84,
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(WidgetSizes.s10),
                        topRight: Radius.circular(WidgetSizes.s10),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0x33848484),
                          blurRadius: 16.0,
                          spreadRadius: 0.0,
                          offset: Offset(0, 0),
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(WidgetSizes.paddingMedium),
                      child: ValueListenableBuilder<ElevatedButtonState>(
                        valueListenable: buttonStateNotifier,
                        builder: (context, buttonState, child) {
                          return ActionButton(
                            buttonState: buttonState,
                            onPressed: buttonState == ElevatedButtonState.active
                                ? () async {
                                    bloc.add(LoadWatchlist());
                                    Future.delayed(
                                        const Duration(milliseconds: 100), () {
                                      Navigator.pop(context);
                                    });
                                  }
                                : () {},
                            label: AppConstants.save,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  void _deleteSymbol(int index, List<bool> selected) {
    deletedSymbols.add(symbolsNotifier.value[index]);

    final updatedSymbols = List<SymbolDetails>.from(symbolsNotifier.value);
    updatedSymbols.removeAt(index);
    symbolsNotifier.value = updatedSymbols;
    bloc.dataState.watchList![bloc.selectedWatchlistIndex].symbols =
        updatedSymbols;
  }


  Future<bool> withoutSavingBackPopUp(BuildContext context) async {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.only(
            left: WidgetSizes.s24,
            right: WidgetSizes.s24,
            bottom: WidgetSizes.s36,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const VerticalScrollBar(),
              Padding(
                padding: const EdgeInsets.only(top: WidgetSizes.s16),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      AppConstants.exit,
                      style: theme.textTheme.titleMedium
                          ?.copyWith(color: colorScheme.onSurface),
                    ),
                    const SizedBox(
                      height: WidgetSizes.s16,
                    ),
                    Text(
                      AppConstants.withoutSavingMsg,
                      style: theme.textTheme.bodySmall!
                          .copyWith(color: colorScheme.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: WidgetSizes.s24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Container(
                          height: WidgetSizes.s50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(WidgetSizes.s25),
                            ),
                            border: Border.all(
                              color: Theme.of(context).primaryColor,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppConstants.no,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: colorScheme.primary),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: WidgetSizes.s24,
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          bloc.add(LoadWatchlist());
                          Navigator.pop(context);
                          Future.delayed(const Duration(milliseconds: 100), () {
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          height: WidgetSizes.s50,
                          decoration: BoxDecoration(
                            borderRadius: const BorderRadius.all(
                              Radius.circular(WidgetSizes.s25),
                            ),
                            color: theme.primaryColor,
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            AppConstants.yes,
                            style: theme.textTheme.bodyMedium
                                ?.copyWith(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
    return result ?? false;
  }

 
}
