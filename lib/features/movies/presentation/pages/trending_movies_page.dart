import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Piratecoin/features/movies/presentation/bloc/trending_movies_bloc.dart';
import 'package:Piratecoin/widgets/movie_list_widget.dart';

class TrendingMovieScreen extends StatelessWidget {
  const TrendingMovieScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => TrendingMoviesBloc()..add(FetchTrendingMovies()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Trending Movies'),
        ),
        body: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
          builder: (context, state) {
            if (state is TrendingMoviesLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is TrendingMoviesLoaded) {
              return const MovieListWidget(
                movies: [],
              );
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
