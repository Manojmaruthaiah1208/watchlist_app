import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import '../../data/models/search_model/search_model.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistUseCase {
  final WatchlistRepository repository;

  GetWatchlistUseCase(this.repository);

  Future<WatchListResponse> callToGetWatch() {
    return repository.getWatchlists();
  }
  Future<SearchDataModel> callToGetSearch() {
    return repository.getSeachlists();
  }
}
