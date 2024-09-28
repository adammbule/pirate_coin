import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class SeriesDetailsScreen extends StatefulWidget {
  final int seriesId;

  SeriesDetailsScreen({required this.seriesId});

  @override
  _SeriesDetailsScreenState createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  String seriesPlot = '';
  String seriesTitle = '';
  String releaseYear = '';
  String showImage = '';
  
  // Fetch movie details
  Future<void> fetchSpecificSeriesDetails() async {
    final url = Uri.parse('https://api.themoviedb.org/3/movie/${widget.seriesId}?language=en-US');
    final headers = {
      'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIyMjM2YWY4ZTc2NjBmMDgwYjFkMjNiNmNlZDY4YiIsInN1YiI6IjY1YWU5YzQ3M2UyZWM4MDBlYmYwMDdhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5gNpkiO9urZ9rBmAuGqdATmCR5LVPVm1zB-sx4lofZk',
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var seriesdata = json.decode(response.body);
        setState(() {
          seriesPlot = seriesdata['overview'];  // Update the moviePlot in the state
          seriesTitle = seriesdata['original_title'];
          releaseYear = seriesdata['release_date'];
          showImage = seriesdata['poster_path'];
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
    fetchSpecificSeriesDetails();  // Fetch movie details when the widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: Text('Tv Show Details'),
      ),
      body: Center(
        child: seriesPlot.isEmpty 
            ? CircularProgressIndicator()  // Show a loading spinner while fetching data
            : Column(
              children: [Text('Movie Title: $seriesTitle'),
              Text('Released: $releaseYear'),
              Text('Movie Plot: $seriesPlot'),
              Expanded(
                child: Image.network('https://image.tmdb.org/t/p/original$showImage', //https://api.themoviedb.org/3/movie/{movie_id}/images, or https://api.themoviedb.org/3/movie/$movieId?language=en-US
                                ),

              ),] ) // Show the fetched movie plot
           
      ),
    );
  }
}

