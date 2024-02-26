
// ignore_for_file: non_constant_identifier_names

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
//import 'package:http/shujaanet.com/coin.dart' as http;
import 'package:flutter_application_1/pirateXchange_container.dart';
import 'package:flutter_application_1/login_container.dart';
import 'package:flutter_application_1/register_container.dart';



void main() {
  //defining the function parameters when defining a function
  runApp(
     MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => CreateScreen(),
        '/home': (context) => const HomeScreen(),
        'third': (context) => const TrendingMovieScreen(),
        'fourth': (context) => const MovieOverviewScreen(),
        '/fifth': (context) => const MyAccountStateless(),
        '/sixth': (context) => const PirateXchangeScreen(),
        '/seven':(context) => const MyWatchlistScreen(),
        //'/eighth':(context) => const MovieScreen(),
      },
    ),
  ); //calling the function arguments when calling a function
}

class StartScreen extends StatelessWidget {
  const StartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 13, 29, 37),
      body: Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text(
              'Hello  World !!',
              style: TextStyle(
                color: Colors.white,
                fontSize: 28.5,
              ),
            ),
          ),
          ElevatedButton(
            // Within the `FirstScreen` widget
            onPressed: () {
              // Navigate to the second screen using a named route.
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ));
            },
            child: const Text('Start'),
          ),
        ]),
      ), //class
    );
  }
}
//change to statefull widgets


class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const title = 'HOME';

    return MaterialApp(
      title: title,
      home: Scaffold(
          backgroundColor: Color.fromARGB(255, 15, 15, 15),
          appBar: AppBar(
            title: const Text(title),
          ),
          body: Row(crossAxisAlignment: CrossAxisAlignment.center, children: [
            /*Container(
            child: GestureDetector(
              onTap: () => '/fourth',
            ),
          
          ),*/
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: ((context) => const MovieOverviewScreen())));
              },
              child: Column(
                children: [
                  Expanded(
                    child: Image.asset('images/madmax.jpg'),
                  ),
                  Text('Movies',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 25,
                  ),)
                ],
              ),
            ),
            GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SeriesOverviewScreen()));
                },
                child: Column(
                  children: [
                    Expanded(
                      child: Image.asset('images/hotd.jpg'),
                    ),
                    Text('Series',
                    style: TextStyle(color: Colors.white, fontSize: 25,))
                  ],
                )),
          ])),
    );
  }
}

class TrendingMovieScreen extends StatelessWidget {
  const TrendingMovieScreen({super.key});
  static const title = 'Trending Movies';
  @override
  Widget build(context) {
    return MaterialApp(
      title: title,
      home: Scaffold(
        backgroundColor: Color.fromARGB(255, 0, 0, 0),
        appBar: AppBar(
          title: const Text(title),
        ),
        body: GridView.count(
          crossAxisCount: 2,
          children: List.generate(
            20,
            (index) {
              return Center(
                child: Text(
                  'Mad Max: Fury Road',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

//create class fot textbox
class TextboxContainer extends StatelessWidget {
  const TextboxContainer({super.key});
  @override
  Widget build(context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(colors: [
          Color.fromARGB(255, 19, 20, 20),
          Color.fromARGB(255, 10, 10, 10),
        ]),
      ),
      child: const Center(
        child: Text(
          'Hello  World !!',
          style: TextStyle(
            color: Colors.white,
            fontSize: 28.5,
          ),
        ),
      ),
    );
  } //build should return a widget

  //class fot the member validation screen
}

//pick custom font for everything
class MovieOverviewScreen extends StatelessWidget {
  const MovieOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Image.asset(//place images in placeholders eventually
            'Images/madmax.jpg',
            height: 300,
            width: 800,
            //fit:BoxFit.fitWidth,
            
          ),
          Text(
            'Mad Max:Fury Road',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/fifth');
              //notifyListeners();
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          Text('Mad Max',
          style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
          Text('Sand, Dystopia, Wild cars, Action!!!', 
          style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
          
          
        ],
      ),
    );
  }
}

class SeriesOverviewScreen extends StatelessWidget {
  const SeriesOverviewScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          const Text(
            'House of The Dragon',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/fifth');
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          Image.asset(
            'Images/hotd.jpg',
            height: 452,
            width: 600,
            fit: BoxFit.contain,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/sixth');
            },
            child: const Text('Play'),)
        ],
      ),
    );
  }
}
class MyAccountStateless extends StatelessWidget{
  const MyAccountStateless ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          ),
      body: MyAccountScreen(),
    );
  }
}
class MyAccountScreen extends StatefulWidget {
  const MyAccountScreen({Key? key}): super(key: key);

  @override
  _MyAccountScreenState createState() => _MyAccountScreenState();
  }

class _MyAccountScreenState extends State<MyAccountScreen>{
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

class MovieScreen extends StatelessWidget {
  final int movieId;
  const MovieScreen ({required this.movieId, Key? key}): super(key: key);

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:MovieDetails(movieId: movieId),
    );
  }
}

class MovieDetails extends StatefulWidget {
  final int movieId;
  const MovieDetails ({required this.movieId, Key? key}): super(key: key);

    @override
  _MovieDetailsState createState () => _MovieDetailsState();
}

class _MovieDetailsState extends State<MovieDetails> {
 late Map<String, dynamic> MovieDets = {};
 //List<dynamic> Movies = [];

  @override
  void initState(){
    super.initState();
    fetchMovieDetails(widget.movieId);
  }
 

Future<Map<String, dynamic>> fetchMovieDetails(movieId) async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/movie/$movieId?language=en-US'),
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

class MyWatchlistScreen extends StatelessWidget {
 const MyWatchlistScreen ({super.key});
 @override
 Widget build(BuildContext context){
  return Scaffold(
    //backgroundColor: Colors.black,
    body: Column(
    children: [
    //MovieId:'848326'),
    ],
    ),);
   }
}
class PirateXchangeScreen extends StatelessWidget {
  const PirateXchangeScreen ({super.key});
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.black,
      body: PirateXchangeMovies(),
    );
  }

}




//add sort by studio--abc, Netflix, CBS, HBO

class Movie {
  final int MovieId;
  final String Title;
  final String Plot;
  final int Rating;
  //final Image Poster;
  Movie({required this.Title, required this.MovieId, required this.Plot, required this.Rating});
 

factory Movie.fromJson(Map<String, dynamic> json){
  return Movie(
    Title: json['original_title'],
    MovieId: json['id'],
    Plot: json['overview'],
    Rating: json['vote_average'],
    //'Released': String release_date,*/
  );
    //throw const FormatException('Failed to load Movie. Retry')
  
}
}



/*Intro to State
State is whatever tools/data you need to rebuild the UI at any moment in time.
Ephemeral- local state -e.g an index being reset to zero once user restarts application.-setState()
App State- State that you want shared between user sessions- login, shopping cart, notifications, user preferences, unread sms
Keep the state above the widgets that use it.
To change the UI, you have to rebuild it
Do not fight the framework ....  UI = f(State)
Everything is a widget in Flutter
Provider-ChangeNotifier, ChangeNotifierProvider & Consumer
ChangeNotifier --> You need to call the notifyListeners() anytime the UI changes.
ChangeNotifierProvider provides an instance of changeNotifier to its descendants. Place above the widgets that access it. Multiprovider to provide for more than one class
Consumer widget build is the only argument - calls the build function. build has the context, ChangeNotifier instance & child.
  --Best practice to put the consumer widget as deep as possible in your widget to avoid rebuilding large chunks of UI due to minor changes on other places.
Performance testing in flutter
TMDB /search, /discover and /find
Remember to setState for Api callbacks*/
