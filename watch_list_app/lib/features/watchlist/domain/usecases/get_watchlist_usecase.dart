import 'package:watch_list_app/features/watchlist/data/models/watchlist_model/watchlist_response.dart';
import '../repositories/watchlist_repository.dart';

class GetWatchlistUseCase {
  final WatchlistRepository repository;

  GetWatchlistUseCase(this.repository);

  Future<WatchlistResponse> call() {
    return repository.getWatchlists();
  }
}
