import '../../domain/repositories/watchlist_repository.dart';
import '../datasources/watchlist_remote_data_source.dart';
import '../models/search_model/search_model.dart';
import '../models/watchlist_model/watchlist_response.dart';

class WatchlistRepositoryImpl implements WatchlistRepository {
  final WatchlistRemoteDataSource remoteDataSource;

  WatchlistRepositoryImpl({required this.remoteDataSource});

  @override
  Future<WatchListResponse> getWatchlists() async {
    return await remoteDataSource.fetchWatchlists();
  }
  @override
  Future<SearchDataModel> getSeachlists() async {
    return await remoteDataSource.fetchSearchlists();
  }
}
