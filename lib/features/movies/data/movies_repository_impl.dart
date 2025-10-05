import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:Piratecoin/features/movies/domain/entities/movie.dart'
    as movie_entity;
import 'package:Piratecoin/features/movies/domain/repositories/movie_repository.dart';
import 'package:Piratecoin/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';

class MovieRepositoryImpl implements MovieRepository {
  final MovieRemoteDataSource remote;
  final SecureStorage storage;

  MovieRepositoryImpl({
    required this.remote,
    required this.storage,
  });

  @override
  Future<List<movie_entity.Movie>> fetchMovieCollection() async {
    // Remote returns a List<Movie> object
    final myMovieCollection = await remote.fetchMovieCollection();
    return myMovieCollection;
  }

  @override
  Future<List<movie_entity.Movie>> fetchTrendingMovies() async {
    // Remote returns a List<Movie>
    final trendingMovies = await remote.fetchTrendingMovies();
    return trendingMovies;
  }

  @override
  Future<List<movie_entity.Movie>> fetchPopularMovies() async {
    // Remote returns a List<Movie>
    final popularMovies = await remote.fetchTrendingMovies();
    return popularMovies;
  }

  @override
  Future<void> logout() async {
    await storage.clearToken();
  }

  @override
  Future<void> fetchWalletBalances() {
    // TODO: implement fetchWalletBalances
    throw UnimplementedError();
  }

  @override
  Future<User?> getCurrentUser() {
    // TODO: implement getCurrentUser
    throw UnimplementedError();
  }
}
