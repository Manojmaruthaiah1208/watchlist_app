import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/constants/app_constants.dart';
import 'package:watch_list_app/core/utils/extensions/object_extension.dart';

import '../../../../../core/constants/widget_sizes.dart';
import '../../../data/models/watchlist_model/watchlist_response.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_event.dart';
import '../../widgets/action_button.dart';
import '../../widgets/vertical_scroll_bar.dart';

class ManageWatchlistPopup extends StatefulWidget {
  const ManageWatchlistPopup(
      {super.key, required this.renameIndex, required this.watchlist});

  final int? renameIndex;
  final List<WatchList> watchlist;

  @override
  State<ManageWatchlistPopup> createState() => _ManageWatchlistPopupState();
}

class _ManageWatchlistPopupState extends State<ManageWatchlistPopup> {
  late final WatchlistBloc bloc = BlocProvider.of<WatchlistBloc>(context);
  late final TextEditingController editWatchController;
  final ValueNotifier<bool> showWatchErrorNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<bool> showWatchExistNotifier = ValueNotifier<bool>(false);
  final ValueNotifier<ElevatedButtonState> modifyButtonStateNotifier =
      ValueNotifier<ElevatedButtonState>(ElevatedButtonState.disable);
  final FocusNode renameTextField = FocusNode();

  @override
  Widget build(BuildContext context) {
    return _buildBottomSheetContent(context);
  }

  @override
  void initState() {
    super.initState();
    editWatchController = TextEditingController(
        text: widget.watchlist[widget.renameIndex ?? 0].watchListName);
    editWatchController.addListener(_onTextChanged);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      renameTextField.requestFocus();
    });
  }

  void _onTextChanged() {
    modifyButtonStateNotifier.value = editWatchController.text.isNotEmpty
        ? ElevatedButtonState.active
        : ElevatedButtonState.disable;
  }

  Widget _buildBottomSheetContent(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return SingleChildScrollView(
      padding:
          EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(WidgetSizes.s16),
                ),
              ),
              padding: const EdgeInsets.all(WidgetSizes.paddingMedium),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const VerticalScrollBar(),
                  const SizedBox(height: WidgetSizes.s27),
                  Text(
                    AppConstants.manageWatchlist,
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: WidgetSizes.paddingLarge),
                  ValueListenableBuilder<bool>(
                    valueListenable: showWatchErrorNotifier,
                    builder: (context, showError, child) {
                      return ValueListenableBuilder<bool>(
                        valueListenable: showWatchExistNotifier,
                        builder: (context, showDuplicateError, child) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              TextField(
                                style: theme.textTheme.bodyMedium!.copyWith(
                                    color: colorScheme.inverseSurface),
                                focusNode: renameTextField,
                                autocorrect: false,
                                controller: editWatchController,
                                maxLength: 16,
                                inputFormatters: <TextInputFormatter>[
                                  FilteringTextInputFormatter.allow(
                                      AppConstants.watchListRegExp),
                                  LengthLimitingTextInputFormatter(16),
                                ],
                                decoration: InputDecoration(
                                  border: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(WidgetSizes.s8),
                                    borderSide: BorderSide(
                                      color: colorScheme.primary,
                                      width: 0.5,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius:
                                        BorderRadius.circular(WidgetSizes.s8),
                                    borderSide: BorderSide(
                                      color: colorScheme.primary,
                                      width: 0.5,
                                    ),
                                  ),
                                  counterText: '',
                                  labelText: AppConstants.enterWatchlistName,
                                  labelStyle: TextStyle(
                                      color: colorScheme.inverseSurface),
                                  helperStyle: TextStyle(
                                      color: colorScheme.inverseSurface),
                                  counterStyle: TextStyle(
                                      color: colorScheme.inverseSurface),
                                  errorStyle: const TextStyle(height: 0),
                                ),
                                onChanged: (value) {
                                  String newValue =
                                      value.replaceAll(RegExp(r'\s+'), ' ');
                                  editWatchController.value =
                                      editWatchController.value.copyWith(
                                    text: newValue,
                                    selection: TextSelection.collapsed(
                                        offset: newValue.length),
                                  );
                                },
                              ),
                              const SizedBox(height: WidgetSizes.paddingMedium),
                              errorText(
                                showDuplicateError
                                    ? AppConstants.alreadyWatchlistExistError
                                    : showError
                                        ? AppConstants.emptyWatchlistError
                                        : AppConstants.watchListHelperText,
                                theme,
                                colorScheme,
                                showDuplicateError || showError,
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  const SizedBox(height: WidgetSizes.s18),
                  Center(
                    child: SizedBox(
                      width: double.infinity,
                      child: ValueListenableBuilder<ElevatedButtonState>(
                        valueListenable: modifyButtonStateNotifier,
                        builder: (context, buttonState, child) {
                          return ActionButton(
                            buttonState: buttonState,
                            onPressed: buttonState == ElevatedButtonState.active
                                ? _onEditWatchlistPressed
                                : () {},
                            label: AppConstants.modify,
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _onEditWatchlistPressed() {
    renameTextField.unfocus();
    String currentName = editWatchController.text;
    bool nameExists = widget.watchlist.any(
      (watchlist) => watchlist.watchListName.trim() == currentName.trim(),
    );

    if (editWatchController.text.isEmpty) {
      showWatchExistNotifier.value = false;
      showWatchErrorNotifier.value = true;
    } else {
      if (nameExists) {
        showWatchExistNotifier.value = true;
        showWatchErrorNotifier.value = false;
      } else {
        showWatchExistNotifier.value = false;
        showWatchErrorNotifier.value = false;

        FocusScope.of(context).unfocus();
        _ManageWatchlist(currentName);
        Navigator.pop(context);
      }
    }
  }

  Widget errorText(
      String errorTxt, ThemeData theme, ColorScheme colorScheme, bool isError) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        isError
            ? Row(children: [
                Icon(Icons.warning),
                const SizedBox(
                  width: WidgetSizes.s2,
                ),
                Text(errorTxt,
                    style: theme.textTheme.labelSmall!
                        .copyWith(color: colorScheme.error))
              ])
            : Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(errorTxt,
                        style: theme.textTheme.labelSmall!
                            .copyWith(color: colorScheme.inverseSurface)),
                    ValueListenableBuilder<TextEditingValue>(
                      valueListenable: editWatchController,
                      builder: (context, value, child) {
                        return Text(
                          '${value.text.length}/16',
                          style: TextStyle(color: colorScheme.inverseSurface),
                        );
                      },
                    ),
                  ],
                ),
              ),
      ],
    );
  }

  void _ManageWatchlist(String watchListName) {
    if (widget.renameIndex.isNotNull) {
      bloc.add(RenameWatchEvent(watchListName, widget.renameIndex ?? 0));
    } else {
      bloc.add(CreateWatchlist(watchListName));
    }
  }

  @override
  void dispose() {
    showWatchExistNotifier.dispose();
    showWatchErrorNotifier.dispose();
    editWatchController.dispose();
    super.dispose();
  }
}
