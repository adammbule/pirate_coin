class Show {
  final String? showId;
  final String? showTitle;
  final String? showPoster;
  final String? verifiedSourceCounter;
  final String? showPlot;

  Show({
    this.showId,
    this.showTitle,
    this.showPoster,
    this.verifiedSourceCounter,
    this.showPlot,
  });

  factory Show.fromJson(Map<String, dynamic> json) {
    return Show(
      showId: json['showId']?.toString(),
      showTitle: json['showTitle']?.toString(),
      showPoster: json['showPoster']?.toString(),
      verifiedSourceCounter: json['verifiedSourceCounter']?.toString(),
      showPlot: json['showPlot']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'showTitle': showTitle,
      'showPlot': showPlot,
      'verifiedSourceCounter': verifiedSourceCounter,
    };
  }
}
