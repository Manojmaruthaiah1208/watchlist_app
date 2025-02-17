// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';

abstract class WatchlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}

class WatchlistReorderEvent extends WatchlistEvent {
  int oldPosition;
  int newPosition;
  List<bool> selected;

  WatchlistReorderEvent(this.oldPosition, this.newPosition, this.selected);
}

class WatchlistTabReorderEvent extends WatchlistEvent {
  int oldPosition;
  int newPosition;
  List<bool> selected;

  WatchlistTabReorderEvent(this.oldPosition, this.newPosition, this.selected);

}

class ChangeWatchTabEvent extends WatchlistEvent {
  final int tabIndex;

   ChangeWatchTabEvent(this.tabIndex);
}

class DeleteSymEvent extends WatchlistEvent {
  final int deleteIndex;

   DeleteSymEvent(this.deleteIndex);
}

class DeleteWatchEvent extends WatchlistEvent {
  final int deleteIndex;
   DeleteWatchEvent(this.deleteIndex);
}


class RenameWatchEvent extends WatchlistEvent {
  String newWatchListname;
  int WatchListindex;
  RenameWatchEvent(this.newWatchListname, this.WatchListindex);
}


class CreateWatchlist extends WatchlistEvent {
  String newWatchListname;
  CreateWatchlist(this.newWatchListname);
}

class addSymbol extends WatchlistEvent {
  final SymbolDetails symbolDetails;
  final int watchIndex;
   addSymbol(this.watchIndex,this.symbolDetails);
}
