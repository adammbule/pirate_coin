import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:Piratecoin/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:Piratecoin/features/movies/data/movies_repository_impl.dart';
import 'package:Piratecoin/features/movies/presentation/bloc/trending_movies_bloc.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:Piratecoin/widgets/theme_widget.dart'; // ✅ Use your custom theme
import 'package:Piratecoin/widgets/movie_details_template.dart';

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
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const PirateTitle('Movies'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white, // 👈 forces the hamburger icon to be white
          ),
        ),
        drawer: const HamburgerMenu(),
        body: BlocBuilder<TrendingMoviesBloc, TrendingMoviesState>(
          builder: (context, state) {
            if (state is TrendingMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              );
            } else if (state is TrendingMoviesLoaded) {
              final trending = state.movies.take(10).toList();
              final popular = state.movies.skip(10).take(10).toList();
              final myMovies = state.movies.skip(20).take(10).toList();
              final fresh = state.movies.skip(30).take(10).toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildMovieRow(context, '🔥 Trending Movies', trending),
                      _buildMovieRow(context, '⭐ Popular Movies', popular),
                      _buildMovieRow(context, '🆕 Fresh Releases', fresh),
                      _buildMovieRow(context, '🎬 My Movies', myMovies),
                    ],
                  ),
                ),
              );
            } else if (state is TrendingMoviesError) {
              return Center(
                child: Text(
                  state.message,
                  style: const TextStyle(color: Colors.white),
                ),
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }

  /// Helper widget: builds a section header and a horizontal list of movie cards
  Widget _buildMovieRow(
      BuildContext context, String title, List<dynamic> movies) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ShaderMask(
            shaderCallback: (bounds) => kPirateGradient.createShader(bounds),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 220,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: movies.length,
              itemBuilder: (context, index) {
                final movie = movies[index];
                return _buildMovieCard(context, movie);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget: builds a single movie card with poster and title
  Widget _buildMovieCard(BuildContext context, dynamic movie) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MovieDetailsTemplate(
              title: movie.movieTitle ?? 'Untitled',
              plot: movie.moviePlot ?? 'No plot available.',
              releaseDate: movie.releaseDate ?? 'Unknown',
              //runtime: movie.runtime ?? 'N/A',
              backgroundImageUrl: movie.moviePoster ??
                  'https://via.placeholder.com/400x600.png?text=No+Image',
            ),
          ),
        );
      },
      child: Container(
        width: 140,
        margin: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: kCardColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                flex: 7,
                child: Image.network(
                  movie.moviePoster ??
                      'https://via.placeholder.com/140x180.png?text=No+Image',
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const Icon(
                    Icons.broken_image,
                    color: Colors.white54,
                    size: 40,
                  ),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 6, vertical: 6),
                  alignment: Alignment.center,
                  child: Text(
                    movie.movieTitle ?? 'Untitled',
                    textAlign: TextAlign.center,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
