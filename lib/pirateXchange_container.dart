import 'dart:io';
import 'dart:js';
import 'dart:convert';
import 'dart:js_interop_unsafe';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
//import 'package:http/shujaanet.com/coin.dart' as http;
import 'package:flutter_application_1/pirateXchange_container.dart';

import 'package:flutter/material.dart';

class PirateXchangeMovies extends StatefulWidget {
  const PirateXchangeMovies ({Key? key}): super(key: key);

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
        HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIyMjM2YWY4ZTc2NjBmMDgwYjFkMjNiNmNlZDY4YiIsInN1YiI6IjY1YWU5YzQ3M2UyZWM4MDBlYmYwMDdhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5gNpkiO9urZ9rBmAuGqdATmCR5LVPVm1zB-sx4lofZk', 
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
        padding: EdgeInsets.all(16.0),
        children: [       
          Text(LatestMovies?['title'] ?? 'Unknown Title'),          
         ]

      )
        : Center(child:  CircularProgressIndicator(),)
      );
    
    
    }

}
