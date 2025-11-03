import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:Piratecoin/features/shows/data/datasources/show_remote_datasource.dart';
import 'package:Piratecoin/features/shows/data/shows_repository_impl.dart';
import 'package:Piratecoin/features/shows/presentation/bloc/trending_shows_bloc.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/services/storage/secure_storage.dart';
import 'package:Piratecoin/widgets/theme_widget.dart'; // ✅ Use your custom theme
import 'package:Piratecoin/widgets/show_details_template.dart';

class TrendingShowScreen extends StatelessWidget {
  const TrendingShowScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dio = Dio();
    final storage = SecureStorage();
    final showRepository = ShowRepositoryImpl(
      remote: ShowRemoteDataSource(dio: dio, storage: storage),
      storage: storage,
    );

    return BlocProvider(
      create: (_) => TrendingShowsBloc(showRepository: showRepository)
        ..add(const FetchTrendingShows()),
      child: Scaffold(
        backgroundColor: kBackgroundColor,
        appBar: AppBar(
          title: const PirateTitle('Shows'),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.white, // 👈 forces the hamburger icon to be white
          ),
        ),
        drawer: const HamburgerMenu(),
        body: BlocBuilder<TrendingShowsBloc, TrendingShowsState>(
          builder: (context, state) {
            if (state is TrendingShowsLoading) {
              return const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              );
            } else if (state is TrendingShowsLoaded) {
              final trending = state.shows.take(10).toList();
              final popular = state.shows.skip(10).take(10).toList();
              final myShows = state.shows.skip(20).take(10).toList();
              final fresh = state.shows.skip(30).take(10).toList();

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _buildShowRow(context, '🔥 Trending Shows', trending),
                      _buildShowRow(context, '⭐ Popular Shows', popular),
                      _buildShowRow(context, '🆕 Fresh Releases', fresh),
                      _buildShowRow(context, '🎬 My Shows', myShows),
                    ],
                  ),
                ),
              );
            } else if (state is TrendingShowsError) {
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

  /// Helper widget: builds a section header and a horizontal list of show cards
  Widget _buildShowRow(
      BuildContext context, String title, List<dynamic> shows) {
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
              itemCount: shows.length,
              itemBuilder: (context, index) {
                final show = shows[index];
                return _buildShowCard(context, show);
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Helper widget: builds a single show card with poster and title
  Widget _buildShowCard(BuildContext context, dynamic show) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ShowDetailsTemplate(
              title: show.showTitle ?? 'Untitled',
              plot: show.showPlot ?? 'No plot available.',
              releaseDate: show.releaseDate ?? 'Unknown',
              trailerUrl: "https://www.youtube.com/watch?v=zSWdZVtXT7E",
              //runtime: show.runtime ?? 'N/A',
              backgroundImageUrl: show.showPoster ??
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
                  show.showPoster ??
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
                    show.showTitle ?? 'Untitled',
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
