import '../../domain/entities/watchlist_entity.dart';
import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote_data_source.dart';
import '../models/watchlist_model/watchlist_response.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WatchlistResponse> getWatchlists() async {
    return await remoteDataSource.fetchWatchlists();
  }

  @override
  Future<void> addWatchlist(WatchlistEntity watchlist) async {
    // Implement API call or local database insertion
  }

  @override
  Future<void> updateWatchlist(WatchlistEntity watchlist) async {
    // Implement API call or local database update
  }

  @override
  Future<void> deleteWatchlist(String id) async {
    // Implement API call or local database deletion
  }
}
