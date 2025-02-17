import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/constants/app_constants.dart';
import 'package:watch_list_app/core/utils/extensions/object_extension.dart';
import '../../../../../core/constants/storage_constants.dart';
import '../../../../../core/constants/store.dart';
import '../../../data/models/watchlist_model/watchlist_response.dart';
import '../../bloc/watchlist_bloc.dart';
import '../../bloc/watchlist_state.dart';
import '../manage_watchlist/manage_watchlist_screen.dart';
import 'watchlist_view.dart';

class WatchlistScreen extends StatefulWidget {
  @override
  State<WatchlistScreen> createState() => _WatchlistScreenState();
}

class _WatchlistScreenState extends State<WatchlistScreen> {

  @override
  void initState() {
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    List<WatchList>? watchLists;

    return Scaffold(
      appBar: AppBar(
        title: Text(AppConstants.watchList),
        actions: [
          TextButton(
            onPressed: () {
              if (watchLists != null) {
                Navigator.push(context, MaterialPageRoute(
                  builder: (ctx) {
                    return BlocProvider.value(
                      value: BlocProvider.of<WatchlistBloc>(context),
                      child: ManageWatchlistScreen(
                        watchlist: watchLists!,
                      ),
                    );
                  },
                ));
              }
            },
            child: Text(
              AppConstants.manageWatchlist,
              style: theme.textTheme.bodySmall
                  ?.copyWith(color: colorScheme.primary),
            ),
          ),
        ],
      ),
      body: BlocBuilder<WatchlistBloc, WatchlistState>(
       
        buildWhen: (previous, current) {
          return (current is WatchlistError ||
              current is WatchlistLoaded ||
              current is WatchlistLoading);
        },
        builder: (context, state) {
          if (state is WatchlistLoading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is WatchlistLoaded &&
              state.watchlistsData.isNotNull) {
            Store().getInstance.setString(
                watchlistData, json.encode(state.watchlistsData!.toJson()));
            watchLists = state.watchlistsData!.watchLists;

            return  WatchlistView(
              watchlist: state.watchlistsData!.watchLists,

            );
          } else if (state is WatchlistError) {
            return Center(child: Text(state.message));
          }
          return Center(child: Text('No data'));
        },
      ),
    );
  }
}
