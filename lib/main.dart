import 'package:flutter/material.dart';
import 'package:Piratecoin/movie_details.dart';
//import 'package:http/bazuunet.com/coin.dart' as http;
import 'package:Piratecoin/pirateXchange_container.dart';
import 'package:Piratecoin/login_container.dart';
import 'package:Piratecoin/register_container.dart';
import 'package:Piratecoin/series_details.dart';
import 'package:Piratecoin/startscreen_container.dart';
import 'package:Piratecoin/trendingmovie_container.dart';
import 'package:Piratecoin/trendingseries_container.dart';

void main() {
  runApp(
    MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => const CreateScreen(),
        '/home': (context) => const HomeScreen(),
        //'third': (context) => const TrendingMovieScreen(),
        '/fifth': (context) => const TrendingMovieScreenfinal(),
        '/ninth': (context) => const SeriesDetailsScreen(seriesId: 0),
      },
      debugShowCheckedModeBanner: false,
    ),
  );
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'HOME';
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(title),
        backgroundColor: Color.fromARGB(30, 30, 30, 30),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Movie Card
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrendingMovieScreenfinal(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/original/hA2ple9q4qnwxp3hKVNhroipsir.jpg',
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Movies',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 30),

            // Series Card
            Expanded(
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TrendingSeriesScreenfinal(),
                    ),
                  );
                },
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black26,
                            blurRadius: 5,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.network(
                          'https://image.tmdb.org/t/p/w500/1XS1oqL89opfnbLl8WnZY1O1uJx.jpg',
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.error),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Series',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
