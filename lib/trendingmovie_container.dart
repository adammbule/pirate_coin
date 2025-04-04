import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'blocdef.dart';



// Function to retrieve the session key for subsequent API calls
Future<String?> getSessionKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('sessionKey'); // Retrieve the session key
}

// Show error dialog function
void _showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text('OK'),
        ),
      ],
    ),
  );
}

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
      _showErrorDialog(context, 'Session Expired', 'Please log in again.');  // Pass context here
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
      _showErrorDialog(context, 'Error', 'Failed to load Movies. Retry');  // Pass context here
    }
  }

  Future<void> fetchMovieDetails(int movieId) async {
    String? sessionKey = await getSessionKey();
    if (sessionKey == null) {
      _showErrorDialog(context, 'Session Expired', 'Please log in again.');  // Pass context here
      return;
    }
    final response = await http.get(
      Uri.parse('$baseurlfinal/movies/moviedetails/$movieId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // You can store or update your movie details here if needed
    } else {
      _showErrorDialog(context, 'Error', 'Failed to load movie details.');  // Pass context here
    }
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Number of columns
        crossAxisSpacing: 10.0, // Spacing between columns
        childAspectRatio: 3 / 4, // Aspect ratio between width & height
        mainAxisSpacing: 10.0, // Spacing between rows
      ),
      itemCount: Movies.length,
      itemBuilder: (BuildContext context, int index) {
        int movieId = int.parse('${Movies[index]['id']}');
        String moviePoster = '${Movies[index]['poster_path']}';
        return GestureDetector(
          onTap: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MovieDetailsScreen(movieId: movieId),  // Pass the movieId as an argument
              ),
            );
          },
          child: Card(
            elevation: 5.0,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Expanded(
                    child: Image.network(
                      'https://image.tmdb.org/t/p/original$moviePoster', // Image URL
                    ),
                  ),
                  Text(
                    Movies[index]['title'] ?? 'Unknown Title',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    Movies[index]['id'] != null
                        ? '${Movies[index]['id']}'
                        : 'Unknown ID',
                    textAlign: TextAlign.left,
                    style: const TextStyle(
                      fontSize: 15.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;
  const MovieDetailsScreen({required this.movieId, super.key});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  late Map<String, dynamic> MovieDets = {};

  @override
  void initState() {
    super.initState();
    fetchMovieDetails(widget.movieId);  // Use widget.movieId here
  }

  Future<void> fetchMovieDetails(int movieId) async {
    String? sessionKey = await getSessionKey();
    final response = await http.get(
      Uri.parse('$baseurlfinal/movies/moviedetails/${widget.movieId}'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        MovieDets = json.decode(response.body);
      });
    } else {
      throw Exception('Failed to load Movie Details.');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(MovieDets['title'] ?? 'Unknown Title')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(MovieDets['title'] ?? 'Unknown Title'),
          Text(MovieDets['release_date'] ?? 'Unknown date'),
          Text(MovieDets['runtime'] != null
              ? '${MovieDets['runtime']} minutes'
              : 'Unknown runtime'),
          Text(MovieDets['overview'] ?? 'Unknown Plot'),
        ],
      ),
    );
  }
}

