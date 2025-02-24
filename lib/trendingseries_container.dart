import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:Piratecoin/series_details.dart';
import 'package:http/http.dart' as http;
import 'package:Piratecoin/blocdef.dart';


class TrendingSeriesScreenfinal extends StatefulWidget {
  const TrendingSeriesScreenfinal({super.key});

  @override
  _TrendingSeriesScreenState createState() => _TrendingSeriesScreenState();
  }

class _TrendingSeriesScreenState extends State<TrendingSeriesScreenfinal>{
  List <dynamic> Series = [];
    
  @override
  void initState(){
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
  final response = await http.get(Uri.parse('$baseurlfinal/series/trendingseries'),
    headers: {
    HttpHeaders.authorizationHeader: auth,
      'accept': 'application/json',

  });
  if (response.statusCode == 200){
    setState(() {
      Series = json.decode(response.body)['results'];
    });
    for (var series in Series){
      int seriesId = series['id'];
      
      await fetchSeriesDetails(seriesId);
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
      itemCount: Series.length,
      itemBuilder: (BuildContext context, int index){
        int seriesId = int.parse('${Series[index] ['id']}');
        String seriesPoster = '${Series[index] ['poster_path']}';
        return GestureDetector(
  onTap: () async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SeriesDetailsScreen(seriesId: seriesId),  // Pass the movieId as an argument
      ),
    );
  },
          child: Card(
            elevation: 5.0,
            child: Padding(padding: const EdgeInsets.all(8.0),
            child: Column(crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Image.network('https://image.tmdb.org/t/p/original$seriesPoster', //https://api.themoviedb.org/3/movie/{movie_id}/images, or https://api.themoviedb.org/3/movie/$movieId?language=en-US
                                ),

              ),
              Text(
                  Series[index]['original_name'],
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              Text('${Series[index] ['id']}',
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

fetchSeriesDetails(int seriesId) {
}

class SeriesScreen extends StatelessWidget {
  final int seriesId;
  const SeriesScreen ({super.key, required this.seriesId});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(),
      body:const SeriesDetails(seriesId: 498),
    );
  }
}

class SeriesDetails extends StatefulWidget {
  final int seriesId;

  const SeriesDetails ({super.key, required this.seriesId});

    @override
  _SeriesDetailsState createState () => _SeriesDetailsState();
}

class _SeriesDetailsState extends State<SeriesDetails> {
 late Map<String, dynamic> SeriesDets = {};
 //List<dynamic> Movies = [];

  @override
  void initState(){
    super.initState();
    fetchSeriesDetails();
  }
 

Future<Map<String, dynamic>> fetchSeriesDetails() async {
    final response = await http.get(
      Uri.parse('https://api.themoviedb.org/3/discover/movie?include_adult=false&include_video=false&language=en-US&page=1&sort_by=popularity.desc'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiI0MDk4ZDA0NzU0NjI5MDNlODRmMGZmNjAxYjQwZjRhNCIsIm5iZiI6MTcwNTk0MjA4Ny45NDU5OTk5LCJzdWIiOiI2NWFlOWM0NzNlMmVjODAwZWJmMDA3YTYiLCJzY29wZXMiOlsiYXBpX3JlYWQiXSwidmVyc2lvbiI6MX0.m-rvfyxU5wUwRy8Z_jypbh2zfqubxpN_OuS8GVaNE48', 
        'accept': 'application/json',
      });

        if (response.statusCode == 200){
          setState(() {
            SeriesDets = json.decode(response.body)['Details'];
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
          Text(SeriesDets['title'] ?? 'Unknown Title'),
          Text(SeriesDets['overview'] ?? 'Unkown Plot')
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

