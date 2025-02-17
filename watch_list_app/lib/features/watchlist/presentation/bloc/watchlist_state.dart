import 'package:equatable/equatable.dart';
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';

abstract class WatchlistState extends Equatable {
  @override
  List<Object> get props => [];
}

class WatchlistInitial extends WatchlistState {}

class WatchlistLoading extends WatchlistState {}

// ignore: must_be_immutable
class WatchlistLoaded extends WatchlistState {
   WatchListResponse? watchlistsData;

  WatchlistLoaded(this.watchlistsData);

}

class WatchlistError extends WatchlistState {
  final String message;

  WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}
class WatchlistChangeState extends WatchlistState {}

// ignore: must_be_immutable
class WatchlistDataState extends WatchlistState {
  List<WatchList>? watchList;

  WatchlistDataState({this.watchList,});
}
