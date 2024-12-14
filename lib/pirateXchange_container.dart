import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
//import 'package:http/shujaanet.com/coin.dart' as http;


class PirateXchangeMovies extends StatefulWidget {
  const PirateXchangeMovies ({super.key});

  @override
  _PirateXchangeMoviesState createState () => _PirateXchangeMoviesState();
}

class _PirateXchangeMoviesState extends State<PirateXchangeMovies> {
  late Map<String, dynamic>? LatestMovies = {};
 //List<dynamic> Movies = [];

  @override
  void initState(){
    super.initState();
    fetchMovieDetails();
  }
 

Future<Map<String, dynamic>> fetchMovieDetails() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/popular?language=en-US&page=1'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDk4ZDA0NzU0NjI5MDNlODRmMGZmNjAxYjQwZjRhNCIsIm5iZiI6MTcwNTk0MjA4Ny45NDU5OTk5LCJzdWIiOiI2NWFlOWM0NzNlMmVjODAwZWJmMDA3YTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.m-rvfyxU5wUwRy8Z_jypbh2zfqubxpN_OuS8GVaNE48', 
        'accept': 'application/json',
      });

        if (response.statusCode == 200){
          setState(() {
            LatestMovies = json.decode(response.body)['Details'];
          }); 
        } else {
          throw Exception('Failed to load Movie Details');
        }
        return{};
  } 

  
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(),
      //backgroundColor: Colors.black,
      body: LatestMovies!= null
      ? GridView.count(
        crossAxisCount: 2,
        padding: const EdgeInsets.all(16.0),
        children: [       
          Text(LatestMovies?['title'] ?? 'Unknown Title'),          
         ]

      )
        : const Center(child:  CircularProgressIndicator(),)
      );
    
    
    }

}
