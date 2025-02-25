import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Piratecoin/blocdef.dart';

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  const MovieDetailsScreen({super.key, required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String moviePlot = '';
  String movieTitle = '';
  String releaseYear = '';
  String moviePoster = '';  // Store the movie poster image URL

  // Fetch movie details
  Future<void> fetchSpecificMovieDetails() async {
    final url = Uri.parse('$baseurl/3/movie/${widget.movieId}?language=en-US');
    final headers = {
      'Authorization': auth,
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var moviedata = json.decode(response.body);
        setState(() {
          moviePlot = moviedata['overview'];  // Update the moviePlot in the state
          movieTitle = moviedata['original_title'];
          releaseYear = moviedata['release_date'];
          moviePoster = moviedata['poster_path'];  // Get the poster image URL
        });
      } else {
        throw Exception('Failed to load movie data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSpecificMovieDetails();  // Fetch movie details when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent, // Remove default background color
      appBar: AppBar(
        title: const Text('Movie Details'),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: moviePoster.isEmpty
                ? Container() // If no poster, don't display anything
                : Image.network(
              'https://image.tmdb.org/t/p/original$moviePoster', // Set the movie poster as background
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.3), // Set some opacity to make text visible
            ),
          ),
          // Content Layer (on top of the background image)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  movieTitle,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 10),

                // Release Year
                Text(
                  'Released: $releaseYear',
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 20),

                // Movie Plot
                Text(
                  'Movie Plot:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(height: 5),
                Text(
                  moviePlot,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
