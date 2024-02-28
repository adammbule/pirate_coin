import 'dart:io';
import 'dart:js';
import 'dart:convert';
import 'dart:js_interop_unsafe';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TrendingMovieScreen extends StatefulWidget {
  const TrendingMovieScreen({Key? key}): super(key: key);

  @override
  _TrendingMovieScreenState createState() => _TrendingMovieScreenState();
  }

class _TrendingMovieScreenState extends State<TrendingMovieScreen>{
  List <dynamic> Movies = [];
    
  @override
  void initState(){
    super.initState();
    fetchMovie();
  }

  Future<void> fetchMovie() async {
  final response = await http.get(Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
    headers: {
    HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIyMjM2YWY4ZTc2NjBmMDgwYjFkMjNiNmNlZDY4YiIsInN1YiI6IjY1YWU5YzQ3M2UyZWM4MDBlYmYwMDdhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5gNpkiO9urZ9rBmAuGqdATmCR5LVPVm1zB-sx4lofZk',
    'accept': 'application/json',

  });
  if (response.statusCode == 200){
    setState(() {
      Movies = json.decode(response.body)['results'];
    });
    for (var movie in Movies){
      int movieId = movie['id'];
      await fetchMovieDetails(movieId);
    }
} else 
  {
    throw const FormatException(' Failed to load Movies. Retry');
  }
}
  @override
  Widget build(BuildContext context){
    return ListView.builder(
      itemCount: Movies.length,
      itemBuilder: (BuildContext context, int index){
        return ListTile(
          subtitle: Text(Movies[index]['title']),
          onTap: () async {
            int movieId = Movies[index]['id'];  
            Navigator.pushNamed(context, 
            MaterialPageRoute(
              builder: (context) => MovieScreen(movieId: movieId),) as String);
          },

        );
      }
    );
  }
}

fetchMovieDetails(int movieId) {
}