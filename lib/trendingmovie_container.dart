import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, //number of columns
        crossAxisSpacing: 10.0, //spacing btn columns
        childAspectRatio: 3/4, //ratio btn width & length
        mainAxisSpacing: 10.0 //space btn rows
        ),
      itemCount: Movies.length,
      itemBuilder: (BuildContext context, int index){
        String movieId = '${Movies[index] ['id']}';
        String moviePoster = '${Movies[index] ['backdrop_path']}';
        return GestureDetector(
          //subtitle: Text(Movies[index]['title']),
          onTap: () async => Navigator.pushNamed(context, 
            MaterialPageRoute(
              builder: (context) => const MovieScreen(),) as String),
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
      Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI5MWIyMjM2YWY4ZTc2NjBmMDgwYjFkMjNiNmNlZDY4YiIsInN1YiI6IjY1YWU5YzQ3M2UyZWM4MDBlYmYwMDdhNiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.5gNpkiO9urZ9rBmAuGqdATmCR5LVPVm1zB-sx4lofZk', 
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
