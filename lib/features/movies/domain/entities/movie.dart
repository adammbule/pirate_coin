class Movie {
  final String? movieId;
  final String? movieTitle;
  final String? moviePoster;
  final String? moviePlot;
  final String? releaseDate;
  final double? voteAverage;

  Movie({
    this.movieId,
    this.movieTitle,
    this.moviePoster,
    this.moviePlot,
    this.releaseDate,
    this.voteAverage,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      movieId: json['id']?.toString(),
      movieTitle: json['title'] ?? json['original_title'] ?? '',
      moviePoster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : null,
      moviePlot: json['overview'] ?? '',
      releaseDate: json['release_date'] ?? '',
      voteAverage: (json['vote_average'] is int)
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': movieId,
      'title': movieTitle,
      'poster_path': moviePoster,
      'overview': moviePlot,
      'releaseDate': releaseDate,
      'vote_average': voteAverage,
    };
  }
}
