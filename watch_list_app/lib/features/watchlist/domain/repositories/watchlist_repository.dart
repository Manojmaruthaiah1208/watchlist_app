
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import '../entities/watchlist_entity.dart';

abstract class WatchlistRepository {
  Future<WatchlistResponse> getWatchlists();
  Future<void> addWatchlist(WatchlistEntity watchlist);
  Future<void> updateWatchlist(WatchlistEntity watchlist);
  Future<void> deleteWatchlist(String id);
}
