class Movie {
  final String? movieId;
  final String? movieTitle;
  final String? moviePoster;
  final String? verifiedSourceCounter;
  final String? moviePlot;

  Movie({
    this.movieId,
    this.movieTitle,
    this.moviePoster,
    this.verifiedSourceCounter,
    this.moviePlot,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['movieId']?.toString(),
      movieTitle: json['movieTitle']?.toString(),
      moviePoster: json['moviePoster']?.toString(),
      verifiedSourceCounter: json['verifiedSourceCounter']?.toString(),
      moviePlot: json['moviePlot']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'movieId': movieId,
      'movieTitle': movieTitle,
      'moviePlot': moviePlot,
      'verifiedSourceCounter': verifiedSourceCounter,
    };
  }
}
