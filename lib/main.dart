import 'package:flutter/material.dart';
import 'package:Piratecoin/trendingmovie_container.dart';
import 'package:Piratecoin/trendingseries_container.dart';
import 'package:Piratecoin/startscreen_container.dart';
import 'package:Piratecoin/login_container.dart';
import 'package:Piratecoin/register_container.dart';
import 'package:Piratecoin/series_details.dart';
import 'package:Piratecoin/presentation/mainScaffold.dart';
import 'package:Piratecoin/presentation/wallet.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => const CreateScreen(),
        '/home': (context) => const HomeScreen(),
        '/fifth': (context) => const TrendingMovieScreenfinal(),
        '/ninth': (context) => const SeriesDetailsScreen(seriesId: 0),
        '/wallet': (context) => WalletScreen(),
        '/marketplace': (context) => PlaceholderScreen(title: 'Marketplace'),
        '/movies': (context) => const TrendingMovieScreenfinal(),
        '/series': (context) => const TrendingSeriesScreenfinal(),
        '/collections': (context) => PlaceholderScreen(title: 'Collections'),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Dashboard',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Wallet Summary
            Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.account_balance_wallet, size: 40, color: Colors.blueGrey),
                    const SizedBox(width: 16),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text("Wallet Balance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        SizedBox(height: 4),
                        Text("💰 153.25 PirateCoins", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Trending Movies
            const Text("Trending Movies", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _trendingCard(
                    context,
                    'https://image.tmdb.org/t/p/w500//vnfgoohSwKNOcRfJOPULXTvX0cu.jpg',
                    'Open Movies',
                    '/movies',
                  ),
                  _trendingCard(
                    context,
                    'https://image.tmdb.org/t/p/w500/jYfMTSiFFK7ffbY2lay4zyvTkEk.jpg',
                    'Watch Now',
                    '/movies',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Trending Series
            const Text("Trending Series", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            SizedBox(
              height: 220,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: [
                  _trendingCard(
                    context,
                    'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
                    'Popular Series',
                    '/series',
                  ),
                  _trendingCard(
                    context,
                    'https://image.tmdb.org/t/p/w500/dg3OindVAGZBjlT3xYKqIAdukPL.jpg',
                    'Top Rated',
                    '/series',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _trendingCard(BuildContext context, String imageUrl, String label, String route) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, route),
      child: Container(
        width: 150,
        margin: const EdgeInsets.only(right: 16),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.network(
                imageUrl,
                height: 180,
                width: 150,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            const SizedBox(height: 8),
            Text(label, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }
}


// Temporary placeholder for screens you haven’t implemented yet
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: title,
      body: Center(child: Text('$title screen coming soon!')),
    );
  }
}
