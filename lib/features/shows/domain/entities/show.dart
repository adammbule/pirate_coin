class Show {
  final String? showId;
  final String? showTitle;
  final String? showPoster;
  final String? showPlot;
  final String? releaseDate;
  final double? voteAverage;

  Show({
    this.showId,
    this.showTitle,
    this.showPoster,
    this.showPlot,
    this.releaseDate,
    this.voteAverage,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      showId: json['id']?.toString(),
      showTitle: json['name'] ?? json['original_title'] ?? '',
      showPoster: json['poster_path'] != null
          ? "https://image.tmdb.org/t/p/w500${json['poster_path']}"
          : null,
      showPlot: json['overview'] ?? '',
      releaseDate: json['first_air_date'] ?? '',
      voteAverage: (json['vote_average'] is int)
          ? (json['vote_average'] as int).toDouble()
          : json['vote_average']?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': showId,
      'title': showTitle,
      'poster_path': showPoster,
      'overview': showPlot,
      'releaseDate': releaseDate,
      'vote_average': voteAverage,
    };
  }
}
