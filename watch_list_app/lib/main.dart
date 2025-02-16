import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/watchlist/presentation/bloc/watchlist_bloc.dart';
import 'features/watchlist/domain/usecases/get_watchlist_usecase.dart';
import 'features/watchlist/data/repositories/watchlist_repository_impl.dart';
import 'features/watchlist/data/datasources/watchlist_remote_data_source.dart';
import 'package:dio/dio.dart';

import 'features/watchlist/presentation/bloc/watchlist_event.dart';
import 'features/watchlist/presentation/pages/main_screen.dart';

void main() {
  final dio = Dio();
  final remoteDataSource = WatchlistRemoteDataSourceImpl(dio: dio);
  final repository = WatchlistRepositoryImpl(remoteDataSource: remoteDataSource);
  final getWatchlistUseCase = GetWatchlistUseCase(repository);

  runApp(MyApp(getWatchlistUseCase: getWatchlistUseCase));
}

class MyApp extends StatelessWidget {
  final GetWatchlistUseCase getWatchlistUseCase;

  const MyApp({super.key, required this.getWatchlistUseCase});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WatchlistBloc(getWatchlistUseCase: getWatchlistUseCase)..add(LoadWatchlist()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Watchlist App',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: MainScreen(),
      ),
    );
  }
}
