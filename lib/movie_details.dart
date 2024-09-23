import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class MovieDetailsScreen extends StatefulWidget {
  final int movieId;

  MovieDetailsScreen({required this.movieId});

  @override
  _MovieDetailsScreenState createState() => _MovieDetailsScreenState();
}

class _MovieDetailsScreenState extends State<MovieDetailsScreen> {
  String moviePlot = '';
  String movieTitle = '';
  String releaseYear = '';
  
  // Fetch movie details
  Future<void> fetchSpecificMovieDetails() async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/${widget.movieId}?language=en-US');
    final headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIyMjM2YWY4ZTc2NjBmMDgwYjFkMjNiNmNlZDY4YiIsInN1YiI6IjY1YWU5YzQ3M2UyZWM4MDBlYmYwMDdhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5gNpkiO9urZ9rBmAuGqdATmCR5LVPVm1zB-sx4lofZk',
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
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Movie Details'),
      ),
      body: Center(
        child: moviePlot.isEmpty 
            ? CircularProgressIndicator()  // Show a loading spinner while fetching data
            : Column(
              children: [Text('Movie Title: $movieTitle'),
              Text('Released: $releaseYear'),
              Text('Movie Plot: $moviePlot')] ) // Show the fetched movie plot
           
      ),
    );
  }
}
