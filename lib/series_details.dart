import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/blocdef.dart';


class SeriesDetailsScreen extends StatefulWidget {
  final int seriesId;

  const SeriesDetailsScreen({super.key, required this.seriesId});

  @override
  _SeriesDetailsScreenState createState() => _SeriesDetailsScreenState();
}

class _SeriesDetailsScreenState extends State<SeriesDetailsScreen> {
  String seriesPlot = '';
  String seriesTitle = '';
  String releaseYear = '';
  String showImage = '';
  List episodes = [];
  String seriesEpisodeId = '';

  
  // Fetch movie details
  Future<void> fetchSpecificSeriesDetails() async {
    final url = Uri.parse('${baseurl}/3/tv/61818/season/1');
    final headers = {
      'Authorization': '${auth}',
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var seriesdata = json.decode(response.body);
        setState(() {
          seriesPlot = seriesdata['_id'];  // Update the moviePlot in the state
          seriesTitle = seriesdata['name'];
          releaseYear = seriesdata['_id'];
          seriesEpisodeId = seriesdata['_id'];
          showImage = seriesdata['poster_path'];
          episodes = seriesdata['episodes'];
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
        title: Text(seriesTitle),
      ),
      body: Center(
        child: episodes.isEmpty 
            ? const CircularProgressIndicator()  // Show a loading spinner while fetching data
            : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    // Extract the episode object from the list at the given index
                  var episode = episodes[index]; 

    // Access the episode name and other properties from the episode object
              return Card(
                margin: const EdgeInsets.symmetric(vertical: 8),
                child: ListTile(
        // Correctly access the episode name here
                title: Text('Episode ${episode['episode_number']}: ${episode['name']}'),
                subtitle: Text(episode['overview']),
      ),
    );
  },
)// Show the fetched movie plot
           
      ),
    );
  }
}

