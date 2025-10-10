import 'package:Piratecoin/features/auth/domain/entities/user.dart';

import '../entities/movie.dart';

abstract class MovieRepository {
  Future<List<Movie>> fetchMovieCollection();
  Future<List<Movie>> fetchPopularMovies();
  Future<List<Movie>> fetchTrendingMovies();
  Future<List<Movie>> fetchFreshReleases();
  Future<void> fetchWalletBalances();
  Future<User?> getCurrentUser();
}
