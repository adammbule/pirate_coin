
// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:flutter_application_1/movie_details.dart';
//import 'package:http/shujaanet.com/coin.dart' as http;
import 'package:flutter_application_1/pirateXchange_container.dart';
import 'package:flutter_application_1/login_container.dart';
import 'package:flutter_application_1/register_container.dart';
import 'package:flutter_application_1/series_details.dart';
import 'package:flutter_application_1/startscreen_container.dart';
import 'package:flutter_application_1/trendingmovie_container.dart';
import 'package:flutter_application_1/trendingseries_container.dart';




void main() {
  //defining the function parameters when defining a function
  runApp(
     MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => const StartScreen(),
        '/second': (context) => const LoginScreen(),
        '/third': (context) => const CreateScreen(),
        '/home': (context) => const HomeScreen(),
        'third': (context) => const TrendingMovieScreen(),
        'fourth': (context) => const MovieOverviewScreen(),
        '/fifth': (context) => const TrendingMovieScreenfinal(),
        '/sixth': (context) => const PirateXchangeScreen(),
        '/seven':(context) => const MyWatchlistScreen(),
        '/eighth':(context) => const MovieDetailsScreen(movieId: 0,),
        '/ninth':(context) => const SeriesDetailsScreen(seriesId: 0,),
      },
    ),
  ); //calling the function arguments when calling a function
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
          backgroundColor: const Color.fromARGB(255, 15, 15, 15),
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
                        builder: ((context) => const TrendingMovieScreenfinal())));
              },
              child: Column(
                children: [
                  Flexible(
                    child: Image.asset('lib/madmax.jpg'),
                  ),
                  const Text('Movies',
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
                          builder: (context) => const TrendingSeriesScreenfinal()));
                },
                child: Column(
                  children: [
                    Flexible(
                      child: Image.asset('lib/hotd.jpg'),
                    ),
                    const Text('Series',
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
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
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
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      body: Column(
        children: [
          Image.asset(//place images in placeholders eventually
            'lib/madmax.jpg',
            height: 300,
            width: 800,
            //fit:BoxFit.fitWidth,
            
          ),
          const Text(
            'Mad Max:Fury Road',
            style: TextStyle(
              color: Colors.white,
              fontSize: 30,
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/fifth');
              //notifyListeners();
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          const Text('Mad Max',
          style: TextStyle(
        color: Colors.white,
        fontSize: 20,
      ),),
          const Text('Sand, Dystopia, Wild cars, Action!!!', 
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
              shape: const CircleBorder(),
            ),
            onPressed: () {
              Navigator.pushNamed(context, '/ninth');
            },
            child: const Text('Play'), //insert clickable icon.
          ),
          Image.asset(
            'lib/hotd.jpg',
            height: 452,
            width: 600,
            fit: BoxFit.contain,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: const CircleBorder(),
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
class TrendingMovieStateless extends StatelessWidget{
  const TrendingMovieStateless ({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          ),
      body: const TrendingMovieScreenfinal(),
    );
  }
}





class MyWatchlistScreen extends StatelessWidget {
 const MyWatchlistScreen ({super.key});
 @override
 Widget build(BuildContext context){
  return const Scaffold(
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
    return const Scaffold(
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
Remember to setState for Api callbacks
BLOC VS CUBIT
Bloc extends a cubit
A cubit uses functions to receive input from UI 
while Bloc uses events to receive input from UI
Blocprovider, bloclistener & blocbuilder
Streams are interactions in the app needed to emit changes in code.*/
