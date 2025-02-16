import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:watch_list_app/core/utils/extensions/object_extension.dart';
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import '../../domain/usecases/get_watchlist_usecase.dart';
import 'watchlist_event.dart';
import 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlistUseCase getWatchlistUseCase;

  WatchlistBloc({required this.getWatchlistUseCase})
      : super(WatchlistInitial()) {
    on<LoadWatchlist>(_onLoadWatchlist);
    on<WatchlistReorderEvent>(_onWatchlistReorderEvent);
    on<ChangeWatchTabEvent>(_onChangeTabEvent);
    on<DeleteSymEvent>(_handleDeleteSymbolEvent);
    on<WatchlistTabReorderEvent>(_onWatchlistTabReorderEvent);
    on<RenameWatchEvent>(_onRenameWatchEvent);
  }
  int selectedWatchlistIndex = 0;
  WatchlistResponse? watchlistsData;
  WatchlistDataState dataState = WatchlistDataState();

  void _onLoadWatchlist(
      LoadWatchlist event, Emitter<WatchlistState> emit) async {
    emit(WatchlistLoading());
    try {
      if (!watchlistsData.isNotNull) {
        watchlistsData = await getWatchlistUseCase.call();
      }
      dataState.watchList = watchlistsData?.watchLists ?? [];

      emit(WatchlistLoaded(watchlistsData));
    } catch (e) {
      emit(WatchlistError('Failed to fetch watchlist'));
    }
  }

  Future<void> _onWatchlistReorderEvent(
    event,
    Emitter<WatchlistState> emit,
  ) async {
    final List<SymbolDetails>? symbols =
        watchlistsData!.watchLists[selectedWatchlistIndex].symbolsList;

    if (event is WatchlistReorderEvent) {
      if (event.newPosition > event.oldPosition) {
        event.newPosition -= 1;
      }
      final SymbolDetails stock = symbols!.removeAt(event.oldPosition);
      symbols.insert(event.newPosition, stock);
      final bool sel = event.selected.removeAt(event.oldPosition);
      event.selected.insert(event.newPosition, sel);
    }

    dataState.watchList?[selectedWatchlistIndex].symbolsList = symbols;
    emit(WatchlistChangeState());
    emit(dataState..watchList = dataState.watchList);
    emit(WatchlistLoaded(watchlistsData));
  }

  Future<void> _onWatchlistTabReorderEvent(
    event,
    Emitter<WatchlistState> emit,
  ) async {
    final List<WatchList>? watchLists = watchlistsData!.watchLists;

    if (event is WatchlistTabReorderEvent) {
      if (event.newPosition > event.oldPosition) {
        event.newPosition -= 1;
      }
      final WatchList stock = watchLists!.removeAt(event.oldPosition);
      watchLists.insert(event.newPosition, stock);
      final bool sel = event.selected.removeAt(event.oldPosition);
      event.selected.insert(event.newPosition, sel);
    }

    dataState.watchList = watchLists;
    emit(WatchlistChangeState());
    emit(dataState..watchList = dataState.watchList);
    selectedWatchlistIndex = 0;
    emit(WatchlistLoaded(watchlistsData));
  }

  Future<void> _onChangeTabEvent(
      ChangeWatchTabEvent event, Emitter<WatchlistState> emit) async {
    selectedWatchlistIndex = event.tabIndex;
  }

  Future<void> _handleDeleteSymbolEvent(
    DeleteSymEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    final List<SymbolDetails>? symbols =
        watchlistsData!.watchLists[selectedWatchlistIndex].symbolsList;

    List<SymbolDetails>? newList =
        symbols!.where((x) => symbols.indexOf(x) != event.deleteIndex).toList();
    watchlistsData!.watchLists[selectedWatchlistIndex].symbolsList = newList;
    emit(WatchlistLoaded(watchlistsData));
  }

  Future<void> _onRenameWatchEvent(
    RenameWatchEvent event,
    Emitter<WatchlistState> emit,
  ) async {
    final List<WatchList>? watchLists = watchlistsData!.watchLists;

    watchLists?[event.WatchListindex].watchListName = event.newWatchListname;
    dataState.watchList = watchLists;
    emit(WatchlistChangeState());
    emit(dataState..watchList = dataState.watchList);
    selectedWatchlistIndex = 0;
    emit(WatchlistLoaded(watchlistsData));
  }
}
