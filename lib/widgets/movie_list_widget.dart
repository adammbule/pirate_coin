import 'package:flutter/material.dart';

import 'package:Piratecoin/features/movies/domain/entities/movie.dart';

class MovieListWidget extends StatelessWidget {
  final List<Movie> movies;

  const MovieListWidget({super.key, required this.movies});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: movies.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(movies[index].movieTitle ?? ''),
        );
      },
    );
  }
}
