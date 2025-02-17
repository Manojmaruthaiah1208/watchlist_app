import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../core/constants/app_constants.dart';
import '../../../../../core/constants/widget_sizes.dart';
import '../../../data/models/watchlist_model/watchlist_response.dart';
import '../../bloc/watchlist_bloc.dart';
import '../edit_watchlist/edit_watchlist.dart';
import '../search/search_screen.dart';

class SymbolsListView extends StatefulWidget {
  SymbolsListView({
    super.key,
    required this.symbols,
    required this.watchlist,
    required this.currentIndex,
  });

  final List<SymbolDetails> symbols;
  final String? watchlist;
  final int currentIndex;

  @override
  State<SymbolsListView> createState() => _SymbolsListViewState();
}

class _SymbolsListViewState extends State<SymbolsListView> {
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    searchController.addListener(() {
      Navigator.push(context, MaterialPageRoute(
        builder: (ctx) {
          return BlocProvider.value(
            value: BlocProvider.of<WatchlistBloc>(context),
            child: SearchScreen(
              symbolList:
                  BlocProvider.of<WatchlistBloc>(context).searchData?.symbols ??
                      [],
              watchListIndex: BlocProvider.of<WatchlistBloc>(context)
                  .selectedWatchlistIndex,
            ),
          );
        },
      ));
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: AppConstants.searchForSym,
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(WidgetSizes.paddingMedium),
            child: ListView.separated(
              itemCount: widget.symbols.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () => {
                    Navigator.push(context, MaterialPageRoute(
                      builder: (ctx) {
                        return BlocProvider.value(
                          value: BlocProvider.of<WatchlistBloc>(context),
                          child: EditWatchlist(
                            watchlist: widget.symbols,
                          ),
                        );
                      },
                    ))
                  },
                  splashColor: Colors.transparent,
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    widget.symbols[index].dispSym ?? '',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                        color: colorScheme.inverseSurface),
                                    overflow: TextOverflow.ellipsis,
                                    softWrap: true,
                                  ),
                                ),
                                const SizedBox(
                                  width: WidgetSizes.s6,
                                ),
                              ],
                            ),
                            Text(
                              widget.symbols[index].exc ?? '',
                              style: theme.textTheme.labelSmall
                                  ?.copyWith(color: colorScheme.inverseSurface),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: WidgetSizes.s20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '4000.5',
                                  style: theme.textTheme.bodyMedium
                                      ?.copyWith(color: Colors.greenAccent),
                                ),
                                Text(
                                  '23.0%',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: Colors.redAccent,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: WidgetSizes.paddingMedium),
                  child: Container(
                    height: 0.5,
                    color: colorScheme.outlineVariant,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
