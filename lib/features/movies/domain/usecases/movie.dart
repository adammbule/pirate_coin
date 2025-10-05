import '../entities/movie.dart';
import '../repositories/movie_repository.dart';

class MovieUseCase {
  final MovieRepository movieRepository;

  MovieUseCase(this.movieRepository);

  Future<List<Movie>> call() async {
    final movie = await movieRepository.fetchMovieCollection();
    return movie;
  }

  Future<List<Movie>> fetchTrendingMovies() async {
    final movies = await movieRepository.fetchTrendingMovies();
    return movies;
  }

  Future<List<Movie>> fetchPopularMovies() async {
    final movies = await movieRepository.fetchPopularMovies();
    return movies;
  }

  Future<void> fetchWalletBalances() async {
    await movieRepository.fetchWalletBalances();
  }
}
