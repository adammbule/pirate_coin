import 'dart:io';
import 'dart:convert';
import 'package:Piratecoin/presentation/mainScaffold.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:Piratecoin/series_details.dart';
import 'package:Piratecoin/blocdef.dart';
import 'package:Piratecoin/presentation/mainScaffold.dart';

class TrendingSeriesScreenfinal extends StatefulWidget {
  const TrendingSeriesScreenfinal({super.key});

  @override
  _TrendingSeriesScreenState createState() => _TrendingSeriesScreenState();
}

class _TrendingSeriesScreenState extends State<TrendingSeriesScreenfinal> {
  List<dynamic> Series = [];

  @override
  void initState() {
    super.initState();
    fetchSeries();
  }

  Future<void> fetchSeries() async {
    String? sessionKey = await getSessionKey();
    if (sessionKey == null) {
      _showErrorDialog(context, 'Session Expired', 'Please log in again.');
      return;
    }

    final response = await http.get(
      Uri.parse('$baseurlfinal/series/trendingseries'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      setState(() {
        var decodedData = json.decode(response.body)['results'];
        Series = decodedData ?? [];
      });

      for (var series in Series) {
        int seriesId = series['id'];
        await fetchSeriesDetails(seriesId);
      }
    } else {
      _showErrorDialog(context, 'Error', 'Failed to load series. Retry.');
    }
  }

  Future<void> fetchSeriesDetails(int seriesId) async {
    String? sessionKey = await getSessionKey();
    if (sessionKey == null) {
      return;
    }

    final response = await http.get(
      Uri.parse('$baseurlfinal/series/getseriesdetails/$seriesId'),
      headers: {
        HttpHeaders.authorizationHeader: 'Bearer $sessionKey',
        'accept': 'application/json',
      },
    );
    // Optional: store or use details as needed
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      title: 'Trending Shows',
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 12.0,
            mainAxisSpacing: 12.0,
            childAspectRatio: 2 / 3,
          ),
          itemCount: Series.length,
          itemBuilder: (BuildContext context, int index) {
            int seriesId = int.parse('${Series[index]['id']}');
            String seriesPoster = '${Series[index]['poster_path']}';
            String title = Series[index]['original_name'] ?? 'Unknown Series';

            return GestureDetector(
              onTap: () async {
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SeriesDetailsScreen(seriesId: seriesId),
                  ),
                );
              },
              child: Card(
                elevation: 6.0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16.0),
                ),
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  children: [
                    Positioned.fill(
                      child: Image.network(
                        'https://image.tmdb.org/t/p/original$seriesPoster',
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Center(child: Icon(Icons.broken_image)),
                        loadingBuilder: (context, child, progress) {
                          if (progress == null) return child;
                          return const Center(child: CircularProgressIndicator());
                        },
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Colors.black87, Colors.transparent],
                            begin: Alignment.bottomCenter,
                            end: Alignment.topCenter,
                          ),
                        ),
                        child: Text(
                          title,
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            shadows: [
                              Shadow(
                                blurRadius: 4.0,
                                color: Colors.black,
                                offset: Offset(1.0, 1.0),
                              ),
                            ],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Utilities

Future<String?> getSessionKey() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString('sessionKey');
}

void _showErrorDialog(BuildContext context, String title, String message) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('OK'),
        ),
      ],
    ),
  );
}
