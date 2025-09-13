import 'package:equatable/equatable.dart';

abstract class TrendingShowsEvent extends Equatable {
  const TrendingShowsEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendingMovies extends TrendingShowsEvent {}
