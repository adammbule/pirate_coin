import 'package:flutter/material.dart';
import 'package:Piratecoin/movie_details.dart';
//import 'package:http/shujaanet.com/coin.dart' as http;
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
        'third': (context) => const TrendingMovieScreen(),
        //'fourth': (context) => const MovieOverviewScreen(),
        '/fifth': (context) => const TrendingMovieScreenfinal(),
        //'/sixth': (context) => const PirateXchangeScreen(),
        //'/seven': (context) => const MyWatchlistScreen(),
        '/eighth': (context) => const MovieDetailsScreen(movieId: 0,),
        '/ninth': (context) => const SeriesDetailsScreen(seriesId: 0,),
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
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Color.fromARGB(30, 30, 30, 30),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Movie Container
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrendingMovieScreenfinal()));
                },
                child: Container(
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
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'lib/madmax.jpg',
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Movies',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 20),  // Space between columns
              // Series Container
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TrendingSeriesScreenfinal()));
                },
                child: Container(
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
                  child: Column(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(15),
                        child: Image.asset(
                          'lib/hotd.jpg',
                          height: 200,
                          width: 150,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Series',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
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

class TrendingMovieScreen extends StatelessWidget {
  const TrendingMovieScreen({super.key});
  static const title = 'Trending Movies';

  @override
  Widget build(context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: const Color.fromARGB(255, 255, 255, 255),
        appBar: AppBar(
          title: const Text(title),
          backgroundColor: Color.fromARGB(30, 30, 30, 30),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            20,
                (index) {
              return Center(
                child: Text(
                  'Mad Max: Fury Road',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

// Similar for other screens
