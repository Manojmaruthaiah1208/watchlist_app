
import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import '../../data/models/search_model/search_model.dart';

abstract class WatchlistRepository {
  Future<WatchListResponse> getWatchlists();
  Future<SearchDataModel> getSeachlists();
}
