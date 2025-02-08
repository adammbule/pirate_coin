import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Piratecoin/movie_details.dart';
import 'package:http/http.dart' as http;
import 'package:Piratecoin/blocdef.dart';

class TrendingMovieScreenfinal extends StatefulWidget {
  const TrendingMovieScreenfinal({super.key});

  @override
  _TrendingMovieScreenState createState() => _TrendingMovieScreenState();
  }

class _TrendingMovieScreenState extends State<TrendingMovieScreenfinal>{
  List <dynamic> Movies = [];
    
  @override
  void initState(){
    super.initState();
    fetchMovie();
  }

  Future<void> fetchMovie() async {
  final response = await http.get(Uri.parse('http://192.168.0.12:3000/getmovies'),
    headers: {
    HttpHeaders.authorizationHeader: auth,
      'accept': 'application/json',
      'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiIxMjMiLCJ1c2VybmFtZSI6InRlc3RVc2VyIiwiaWF0IjoxNzM2NzkxMjc3LCJleHAiOjE3MzY3OTQ4Nzd9._bUn6HjSq3nCZ6Qa6QW5l6ZV7nLOHpwHmeg5QGCBY2w',

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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //number of columns
        crossAxisSpacing: 10.0, //spacing btn columns
        childAspectRatio: 3/4, //ratio btn width & length
        mainAxisSpacing: 10.0 //space btn rows
        ),
      itemCount: Movies.length,
      itemBuilder: (BuildContext context, int index){
        int movieId = int.parse('${Movies[index] ['id']}');
        String moviePoster = '${Movies[index] ['poster_path']}';
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
            child: Padding(padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image.network('https://image.tmdb.org/t/p/original$moviePoster', //https://api.themoviedb.org/3/movie/{movie_id}/images, or https://api.themoviedb.org/3/movie/$movieId?language=en-US
                                ),

              ),
              Text(
                  Movies[index]['title'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text('${Movies[index] ['id']}',
                    textAlign:  TextAlign.left,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                    )
                //fetch movie images
        ]),
          ),

        ));
      }
    );
  }
}

fetchMovieDetails(int movieId) {
}

class MovieScreen extends StatelessWidget {
  //final int movieId;
  const MovieScreen ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:const MovieDetails(),
    );
  }
}

class MovieDetails extends StatefulWidget {
  //final int movieId;
  const MovieDetails ({super.key});

    @override
  _MovieDetailsState createState () => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
 late Map<String, dynamic> MovieDets = {};
 //List<dynamic> Movies = [];

  @override
  void initState(){
    super.initState();
    fetchMovieDetails();
  }
 

Future<Map<String, dynamic>> fetchMovieDetails() async {
    final response = await http.get(
      Uri.parse('$baseurl/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
      headers: {
        HttpHeaders.authorizationHeader: '$auth',
        'accept': 'application/json',
      });

        if (response.statusCode == 200){
          setState(() {
            MovieDets = json.decode(response.body)['Details'];
          }); 
        } else {
          throw Exception('Failed to load Movie Details./n Tap to try again/n');
        }
        return{};
  } 

  
   @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      //backgroundColor: Colors.black,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children:[
          Text(MovieDets['title'] ?? 'Unknown Title'),
          Text(MovieDets['overview'] ?? 'Unkown Plot')
        ],
      ),
    
    );
    


  }

}

/*BLOC VS CUBIT
Bloc extends a cubit
A cubit uses functions to receive input from UI 
while Bloc uses events to receive input from UI
Blocprovider, bloclistener & blocbuilder
Streams are interactions in the app needed to emit changes in code.*/
