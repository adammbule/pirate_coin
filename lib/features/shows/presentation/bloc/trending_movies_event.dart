import 'package:equatable/equatable.dart';

abstract class TrendingMoviesEvent extends Equatable {
  const TrendingMoviesEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendingMovies extends TrendingMoviesEvent {}
