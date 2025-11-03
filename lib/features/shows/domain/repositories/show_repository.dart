import 'package:Piratecoin/features/auth/domain/entities/user.dart';

import '../entities/show.dart';

abstract class ShowRepository {
  Future<List<Show>> fetchShowCollection();
  Future<List<Show>> fetchPopularShows();
  Future<List<Show>> fetchTrendingShows();
  Future<List<Show>> fetchFreshReleases();
  Future<void> fetchWalletBalances();
  Future<User?> getCurrentUser();
}
