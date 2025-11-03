import '../entities/show.dart';
import '../repositories/show_repository.dart';

class ShowUseCase {
  final ShowRepository showRepository;

  ShowUseCase(this.showRepository);

  Future<List<Show>> call() async {
    final Show = await showRepository.fetchShowCollection();
    return Show;
  }

  Future<List<Show>> fetchTrendingShows() async {
    final Shows = await showRepository.fetchTrendingShows();
    return Shows;
  }

  Future<List<Show>> fetchPopularShows() async {
    final Shows = await showRepository.fetchPopularShows();
    return Shows;
  }

  Future<List<Show>> fetchFreshReleases() async {
    final Shows = await showRepository.fetchFreshReleases();
    return Shows;
  }

  Future<void> fetchWalletBalances() async {
    await showRepository.fetchWalletBalances();
  }
}
