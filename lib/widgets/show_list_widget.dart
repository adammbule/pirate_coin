import 'package:flutter/material.dart';

class ShowListWidget extends StatelessWidget {
  final List<String> Shows;

  const ShowListWidget({super.key, required this.Shows});

  @override
  Widget build(BuildContext context) {
    // Display only the first 50 Shows
    final displayedShows = Shows.take(50).toList();

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
                      leftIndex < displayedShows.length
                          ? displayedShows[leftIndex]
                          : '',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      rightIndex < Shows.length ? Shows[rightIndex] : '',
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
