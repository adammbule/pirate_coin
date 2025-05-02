import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'blocdef.dart';
import 'movie_details.dart'; // Make sure this exists

class TrendingMovieScreenfinal extends StatefulWidget {
  const TrendingMovieScreenfinal({super.key});

  @override
  _TrendingMovieScreenState createState() => _TrendingMovieScreenState();
}

class _TrendingMovieScreenState extends State<TrendingMovieScreenfinal> {
  List<dynamic> Movies = [];

  @override
  void initState() {
    super.initState();
    fetchMovie();
  }

  Future<void> fetchMovie() async {
    String? sessionKey = await getSessionKey();
    if (sessionKey == null) {
      _showErrorDialog(context, 'Session Expired', 'Please log in again.');
      return;
    }

    final response = await http.get(
      Uri.parse('$baseurlfinal/movies/trendingmovies'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var decodedData = json.decode(response.body)['results'];
        Movies = decodedData ?? [];
      });
      for (var movie in Movies) {
        int movieId = movie['id'];
        await fetchMovieDetails(movieId);
      }
    } else {
      _showErrorDialog(context, 'Error', 'Failed to load Movies. Retry');
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
    String? sessionKey = await getSessionKey();
    if (sessionKey == null) {
      _showErrorDialog(context, 'Session Expired', 'Please log in again.');
      return;
    }
    final response = await http.get(
      Uri.parse('$baseurlfinal/movies/moviedetails/$movieId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );
    // Optional: handle individual movie details if needed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Trending Movies"),
        backgroundColor: const Color.fromARGB(221, 95, 95, 95),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: Movies.length,
          itemBuilder: (BuildContext context, int index) {
            int movieId = int.parse('${Movies[index]['id']}');
            String moviePoster = '${Movies[index]['poster_path']}';
            String title = Movies[index]['title'] ?? 'Unknown Title';

            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MovieDetailsScreen(movieId: movieId),
                  ),
                );
              },
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original$moviePoster',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Utilities

Future<String?> getSessionKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('sessionKey');
}

void _showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
