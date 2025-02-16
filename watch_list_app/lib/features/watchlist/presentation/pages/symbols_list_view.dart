import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/constants/widget_sizes.dart';
import '../../data/models/watchlist_model/watchlist_response.dart';
import '../bloc/watchlist_bloc.dart';
import 'edit_watchlist/edit_watchlist.dart';

class SymbolsListView extends StatelessWidget {
  const SymbolsListView({
    super.key,
    required this.symbols,
    required this.watchlist,
    required this.watchlistId,
    required this.currentIndex,
    required this.onRefreshCallback,
  });

  final List<SymbolDetails> symbols;
  final String? watchlist;
  final String? watchlistId;
  final int currentIndex;
  final Future<void> Function() onRefreshCallback;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.all(WidgetSizes.paddingMedium),
      child: GestureDetector(
        onLongPress: () {},
        child: ListView.separated(
          itemCount: symbols.length,
          itemBuilder: (context, index) {
            return InkWell(
              onTap: () => {
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) {
                    return BlocProvider.value(
                      value: BlocProvider.of<WatchlistBloc>(context),
                      child: EditWatchlist(
                        watchlist: symbols,
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
                        Flexible(
                          child: Text(
                            'tcs',
                            style: theme.textTheme.bodySmall
                                ?.copyWith(color: colorScheme.inverseSurface),
                            overflow: TextOverflow.ellipsis,
                            softWrap: true,
                          ),
                        ),
                        Text(
                          symbols[index].exc ?? '',
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
    );
  }
}
