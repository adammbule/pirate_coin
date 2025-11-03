import 'package:Piratecoin/features/auth/domain/entities/user.dart';
import 'package:Piratecoin/features/shows/domain/entities/show.dart'
    as show_entity;
import 'package:Piratecoin/features/shows/domain/repositories/show_repository.dart';
import 'package:Piratecoin/features/shows/data/datasources/show_remote_datasource.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';

class ShowRepositoryImpl implements ShowRepository {
  final ShowRemoteDataSource remote;
  final SecureStorage storage;

  ShowRepositoryImpl({
    required this.remote,
    required this.storage,
  });

  @override
  Future<List<show_entity.Show>> fetchShowCollection() async {
    // Remote returns a List<Show> object
    final myShowCollection = await remote.fetchShowCollection();
    return myShowCollection;
  }

  @override
  Future<List<show_entity.Show>> fetchTrendingShows() async {
    // Remote returns a List<Show>
    final trendingShows = await remote.fetchTrendingShows();
    return trendingShows;
  }

  @override
  Future<List<show_entity.Show>> fetchPopularShows() async {
    // Remote returns a List<Show>
    final popularShows = await remote.fetchTrendingShows();
    return popularShows;
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

  @override
  Future<List<show_entity.Show>> fetchFreshReleases() {
    // TODO: implement fetchFreshReleases
    final freshRleases = remote.fetchFreshReleases();
    throw UnimplementedError();
  }
}
