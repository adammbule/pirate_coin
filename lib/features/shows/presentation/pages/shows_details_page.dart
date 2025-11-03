import 'package:flutter/material.dart';
import 'package:Piratecoin/widgets/hamburger_menu.dart';
import 'package:Piratecoin/widgets/movie_details_template.dart';

class MovieDetailsScreen extends StatelessWidget {
  final String title;
  final String plot;
  final String releaseDate;
  //final String runtime;
  final String backgroundImageUrl;
  final String? director;
  final String? trailerUrl;
  final List<String>? genres;

  const MovieDetailsScreen({
    super.key,
    required this.title,
    required this.plot,
    required this.releaseDate,
    //required this.runtime,
    required this.backgroundImageUrl,
    this.director,
    this.trailerUrl,
    this.genres,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const HamburgerMenu(),
      body: MovieDetailsTemplate(
        title: title,
        plot: plot,
        releaseDate: releaseDate,
        //runtime: runtime,
        backgroundImageUrl: backgroundImageUrl,
        director: director,
        trailerUrl: "https://www.youtube.com/watch?v=zSWdZVtXT7E", //trailerUrl,
        genres: genres,
      ),
    );
  }
}
