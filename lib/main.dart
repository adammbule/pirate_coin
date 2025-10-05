import 'package:Piratecoin/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:Piratecoin/features/movies/domain/repositories/movie_repository.dart';
import 'package:Piratecoin/features/movies/presentation/bloc/trending_movies_bloc.dart';
import 'package:flutter/material.dart';
import 'package:Piratecoin/core/routers/routes.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'features/auth/presentation/bloc/auth_bloc.dart';
import 'features/auth/domain/repositories/auth_repository.dart';
import 'features/auth/data/datasources/auth_remote_datasource.dart';
import 'services/storage/secure_storage.dart';
import 'package:dio/dio.dart';
import 'features/auth/data/datasources/auth_repository_impl.dart';
import 'features/movies/data/movies_repository_impl.dart';

void main() {
  // Initialize dependencies
  final dio = Dio();
  final secureStorage = SecureStorage();

  // Remote data source
  final remoteDataSource = AuthRemoteDataSource(
    dio: dio,
    storage: secureStorage,
  );

  // Repository
  final AuthRepository authRepository = AuthRepositoryImpl(
    remote: remoteDataSource,
    storage: secureStorage,
  );

  final MovieRepository = MovieRepositoryImpl(
    remote: MovieRemoteDataSource(
        dio: dio,
        storage:
            secureStorage), // You need to create a MovieRemoteDataSource similar to AuthRemoteDataSource
    storage: secureStorage,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => AuthBloc(
            authRepository: authRepository,
            storage: secureStorage,
          ),
        ),
        BlocProvider(
          create: (_) => TrendingMoviesBloc(
            movieRepository: MovieRepository,
          ),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'PirateCoin',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: AppRoutes.routes, // defined in core/routers/routes.dart
    );
  }
}
