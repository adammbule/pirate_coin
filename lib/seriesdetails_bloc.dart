import 'package:equatable/equatable.dart';

abstract class SeriesDetailsEvent extends Equatable {
  SeriesDetailsEvent({required super.seriesId});

  @override
  List<Object> get props => [];
}

class FetchSeriesDetailsEvent extends SeriesDetailsEvent {
  final int seriesId;

  const FetchSeriesDetailsEvent(this.seriesId);

  @override
  List<Object> get props => [seriesId];
}
