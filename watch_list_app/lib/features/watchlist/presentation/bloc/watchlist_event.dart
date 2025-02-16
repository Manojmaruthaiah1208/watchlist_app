// ignore_for_file: must_be_immutable

import 'package:equatable/equatable.dart';

abstract class WatchlistEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class LoadWatchlist extends WatchlistEvent {}
class AddWatchlist extends WatchlistEvent {}
class UpdateWatchlist extends WatchlistEvent {}
class DeleteWatchlist extends WatchlistEvent {}

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

class RenameWatchEvent extends WatchlistEvent {
  String newWatchListname;
  int WatchListindex;
  RenameWatchEvent(this.newWatchListname, this.WatchListindex);
}

