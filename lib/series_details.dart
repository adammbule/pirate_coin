import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:Piratecoin/blocdef.dart';

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
  String showImage = '';  // Store the image URL
  List seasons = [];  // Store the list of seasons
  List episodes = [];  // Store the list of episodes for selected season

  // Fetch series details
  Future<void> fetchSpecificSeriesDetails() async {
    final url = Uri.parse('$baseurlfinal/series/getseriesdetails/${widget.seriesId}/');
    final headers = {
      'Authorization': auth,
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var seriesdata = json.decode(response.body);
        setState(() {
          seriesPlot = seriesdata['overview'];
          seriesTitle = seriesdata['original_name'];
          releaseYear = seriesdata['first_air_date'];
          showImage = seriesdata['poster_path']; // Get the poster image URL
          seasons = seriesdata['seasons']; // Populate the seasons list
        });
      } else {
        throw Exception('Failed to load series data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  // Fetch episodes for a specific season
  Future<void> fetchEpisodesForSeason(int seasonNumber) async {
    final url = Uri.parse('$baseurlfinal/series/getseriesdetails/${widget.seriesId}/$seasonNumber/');
    final headers = {
      'Authorization': auth,
      'accept': 'application/json',
    };

    try {
      final response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        var seasonData = json.decode(response.body);
        setState(() {
          episodes = seasonData['episodes']; // Populate episodes list for the selected season
        });
      } else {
        throw Exception('Failed to load episodes data');
      }
    } catch (error) {
      throw Exception('Error: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchSpecificSeriesDetails(); // Fetch series details when widget is created
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(seriesTitle),
      ),
      body: Stack(
        children: [
          // Background Image
          Positioned.fill(
            child: showImage.isEmpty
                ? Container()
                : Image.network(
              'https://image.tmdb.org/t/p/original$showImage',
              fit: BoxFit.cover,
              opacity: AlwaysStoppedAnimation(0.3), // Add some opacity to make text readable
            ),
          ),
          // Content on top of the background image
          Column(
            children: [
              // Seasons row: horizontally scrollable list of seasons
              Container(
                height: 120,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: seasons.length,
                  itemBuilder: (context, index) {
                    var season = seasons[index];
                    return GestureDetector(
                      onTap: () {
                        // When a season is clicked, fetch the episodes for that season
                        fetchEpisodesForSeason(season['season_number']);
                      },
                      child: Card(
                        margin: const EdgeInsets.all(8),
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Column(
                            children: [
                              Text(
                                'Season ${season['season_number']}',
                                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                              Text('${season['episode_count']} Episodes'),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Show episodes for the selected season below
              Expanded(
                child: episodes.isEmpty
                    ? const Center(child: Text('Select a season to view episodes'))
                    : ListView.builder(
                  itemCount: episodes.length,
                  itemBuilder: (context, index) {
                    var episode = episodes[index];
                    return Card(
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      child: ListTile(
                        title: Text('Episode ${episode['episode_number']}: ${episode['name']}'),
                        subtitle: Text(episode['overview'] ?? 'No Overview Available'),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
