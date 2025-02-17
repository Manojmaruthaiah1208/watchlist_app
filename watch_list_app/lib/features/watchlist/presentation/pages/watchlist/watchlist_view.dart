import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/utils/extensions/object_extension.dart';
import 'package:watch_list_app/features/watchlist/presentation/pages/search/search_screen.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/widget_sizes.dart';
import '../../../data/models/watchlist_model/watchlist_response.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_event.dart';
import '../../widgets/action_button.dart';
import 'symbols_list_view.dart';

class WatchlistView extends StatefulWidget {
  const WatchlistView({
    super.key,
    required this.watchlist,
  });

  final List<WatchList> watchlist;


  @override
  State<WatchlistView> createState() => _WatchlistViewState();
}

class _WatchlistViewState extends State<WatchlistView>
    with TickerProviderStateMixin {
  late TabController _tabController;
  late final WatchlistBloc bloc = BlocProvider.of<WatchlistBloc>(context);
  late int currentIndex;
  late List<bool> selected;

  @override
  void initState() {
    super.initState();
    currentIndex = bloc.selectedWatchlistIndex;
        _tabController = TabController( 
      initialIndex: currentIndex,
      length: widget.watchlist.length,
      vsync: this,
    )..addListener(
        () {
          if (_tabController.indexIsChanging) {
            currentIndex = _tabController.index;
          } else if (_tabController.index != _tabController.previousIndex) {
            currentIndex = _tabController.index;
            changeTab(currentIndex);
          }
        },
      );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_tabController.index >= widget.watchlist.length) {
      currentIndex = bloc.selectedWatchlistIndex;
      _tabController.index = currentIndex;
    }
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    _tabController = TabController( // For Temp fix for length update
      initialIndex: currentIndex,
      length: widget.watchlist.length,
      vsync: this,
    )..addListener(
        () {
          if (_tabController.indexIsChanging) {
            currentIndex = _tabController.index;
          } else if (_tabController.index != _tabController.previousIndex) {
            currentIndex = _tabController.index;
            changeTab(currentIndex);
          }
        },
      );

    return Column(
        children: [
          Container(
            decoration: BoxDecoration(color: colorScheme.surfaceContainerLow),
            height: WidgetSizes.s48,
            width: double.infinity,
            child: Row(
              children: [
                Expanded(
                  child: DefaultTabController(
                    initialIndex: currentIndex,
                    length: widget.watchlist.length,
                    child: TabBar(
                      labelStyle: theme.textTheme.labelLarge,
                      labelColor: colorScheme.onSurface,
                      unselectedLabelColor: colorScheme.onSurface,
                      unselectedLabelStyle: theme.textTheme.labelSmall,
                      dividerColor: colorScheme.surfaceContainerLow,
                      isScrollable: true,
                      tabAlignment: TabAlignment.start,
                      controller: _tabController,
                      tabs: widget.watchlist.asMap().entries.map(
                        (entry) {
                          final e = entry.value;
                          return Tab(
                            child: Text('${e.watchListName}'),
                          );
                        },
                      ).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: widget.watchlist.asMap().entries.map(
                (entry) {
                  final index = entry.key;
                  final e = entry.value;
                  if ((e.symbols.length) > 0) {
                    return SymbolsListView(
                      symbols: e.symbols ,
                      watchlist: e.watchListName,
                      currentIndex: index,
                    );
                  }
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(AppConstants.noData),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: SizedBox(
                            width: WidgetSizes.s200,
                            child: ActionButton(
                              buttonState: ElevatedButtonState.active,
                              onPressed: () {
                                if (bloc.searchData.isNotNull) {
                                  Navigator.push(context, MaterialPageRoute(
                                    builder: (ctx) {
                                      return BlocProvider.value(
                                        value: bloc,
                                        child: SearchScreen(
                                          symbolList:
                                              bloc.searchData?.symbols ?? [],
                                              watchListIndex: currentIndex,
                                        ),
                                      );
                                    },
                                  ));
                                }
                              },
                              label: AppConstants.search,
                            ),
                          ),
                        )
                      ],
                    ),
                  );
                },
              ).toList(),
            ),
          ),
        ],
      );
  }

  void changeTab(int index) {
    bloc.add(ChangeWatchTabEvent(index));
  }
}
