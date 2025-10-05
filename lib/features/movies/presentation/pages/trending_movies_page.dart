import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:Piratecoin/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:Piratecoin/features/movies/data/movies_repository_impl.dart';
import 'package:Piratecoin/features/movies/presentation/bloc/trending_movies_bloc.dart';
import 'package:Piratecoin/widgets/movie_list_widget.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';

class TrendingMovieScreen extends StatelessWidget {
  const TrendingMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final storage = SecureStorage();
    final movieRepository = MovieRepositoryImpl(
      remote: MovieRemoteDataSource(dio: dio, storage: storage),
      storage: storage,
    );

    return BlocProvider(
      create: (_) => TrendingMoviesBloc(movieRepository: movieRepository)
        ..add(const FetchTrendingMovies()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Trending Movies')),
        drawer: const HamburgerMenu(),
        body: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
          builder: (context, state) {
            if (state is TrendingMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrendingMoviesLoaded) {
              return MovieListWidget(movies: state.movies);
            } else if (state is TrendingMoviesError) {
              return Center(child: Text(state.message));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
