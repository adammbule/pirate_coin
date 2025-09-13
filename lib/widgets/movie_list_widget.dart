import 'package:flutter/material.dart';

class MovieListWidget extends StatelessWidget {
  final List<String> movies;

  const MovieListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    // Display only the first 50 movies
    final displayedMovies = movies.take(50).toList();

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Table(
          columnWidths: const {
            0: FlexColumnWidth(1),
            1: FlexColumnWidth(1),
          },
          border: TableBorder.all(color: Colors.grey),
          children: List.generate(
            50,
            (index) {
              final leftIndex = index;
              final rightIndex = index + 50;
              return TableRow(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      leftIndex < displayedMovies.length
                          ? displayedMovies[leftIndex]
                          : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      rightIndex < movies.length ? movies[rightIndex] : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
