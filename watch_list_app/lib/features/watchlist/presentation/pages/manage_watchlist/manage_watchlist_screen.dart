import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import 'package:watch_list_app/features/watchlist/presentation/pages/manage_watchlist/manage_watchlist_popup.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/widget_sizes.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_event.dart';
import '../../bloc/watchlist_state.dart';
import '../../widgets/action_button.dart';

class ManageWatchlistScreen extends StatefulWidget {
  ManageWatchlistScreen({
    super.key,
    required this.watchlist,
  });

  final List<WatchList> watchlist;

  @override
  State<ManageWatchlistScreen> createState() => _ManageWatchlistScreenState();
}

class _ManageWatchlistScreenState extends State<ManageWatchlistScreen> {
  late final WatchlistBloc bloc;
  late ValueNotifier<List<WatchList>> watchlistNotifier;
  late List<bool> selected;
  late bool isModified = false;
  late bool isSymbolDeleted = false;
  late bool isSymbolRename = false;
  ValueNotifier<bool> withoutSaving = ValueNotifier<bool>(true);
  late final ValueNotifier<bool> isEditableNotifier = ValueNotifier(false);
  final ValueNotifier<ElevatedButtonState> buttonStateNotifier =
      ValueNotifier<ElevatedButtonState>(ElevatedButtonState.disable);
  Map<String, dynamic> reqData = {};
  List<WatchList> deletedWatchList = [];
  final reorderIndexNotifier = ValueNotifier<int>(-1);
  final ValueNotifier<bool> showWatchErrorNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showWatchExistNotifier = ValueNotifier<bool>(false);

  @override
  void initState() {
    bloc = BlocProvider.of<WatchlistBloc>(context);
    watchlistNotifier = ValueNotifier(widget.watchlist);
    selected = List.generate(widget.watchlist.length, (index) => false);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.manageWatchlist),
        actions: [
          TextButton(
            onPressed: () {
              showManageWatchlistBottomSheet(null);
            },
            child: Text(
              AppConstants.addWatchlist,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WatchlistLoaded) {
            return Column(
              children: [
                Expanded(
                  child: ValueListenableBuilder<List<WatchList>>(
                    valueListenable: watchlistNotifier,
                    builder: (context, watchList, _) {
                      return ReorderableListView.builder(
                        onReorderStart: (index) =>
                            reorderIndexNotifier.value = index,
                        onReorderEnd: (index) =>
                            reorderIndexNotifier.value = -1,
                        onReorder: (int oldIndex, int newIndex) {
                          final bloc = BlocProvider.of<WatchlistBloc>(context);
                          bloc.add(
                            WatchlistTabReorderEvent(
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
                        itemCount: watchList.length,
                        itemBuilder: (context, index) {
                          return ValueListenableBuilder(
                            key: ObjectKey(watchList[index]),
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
                                        watchList[index].watchListName,
                                        style:
                                            theme.textTheme.bodySmall?.copyWith(
                                          color: colorScheme.inverseSurface,
                                        ),
                                      ),
                                      subtitle: Text(
                                        '${(watchList[index].symbols.length)} Symbols',
                                        style: theme.textTheme.labelSmall
                                            ?.copyWith(
                                          color: colorScheme.inverseSurface,
                                        ),
                                      ),
                                      trailing: SizedBox(
                                        width: WidgetSizes.s100,
                                        child: Row(
                                          children: [
                                            IconButton(
                                              icon: Icon(Icons.edit),
                                              onPressed: () {
                                                showManageWatchlistBottomSheet(
                                                    index);
                                              },
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.delete),
                                              onPressed: () {
                                                bloc.add(
                                                  DeleteWatchEvent(
                                                    index,
                                                  ),
                                                );
                                                isModified = true;
                                                withoutSaving.value = false;
                                                buttonStateNotifier.value =
                                                    ElevatedButtonState.active;
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    if (index < watchList.length - 1)
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
            );
          } else if (state is WatchlistError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text(AppConstants.noData));
        },
      ),
    );
  }

  void showManageWatchlistBottomSheet(int? renameIndex) {
    final watchlistBloc = BlocProvider.of<WatchlistBloc>(context);
    isModified = true;
    withoutSaving.value = false;
    buttonStateNotifier.value = ElevatedButtonState.active;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius:
            BorderRadius.vertical(top: Radius.circular(WidgetSizes.s16)),
      ),
      builder: (context) {
        return BlocProvider.value(
          value: watchlistBloc,
          child: ManageWatchlistPopup(
            watchlist: watchlistNotifier.value,
            renameIndex: renameIndex,
          ),
        );
      },
    );
  }
}
