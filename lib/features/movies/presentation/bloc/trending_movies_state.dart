import 'package:equatable/equatable.dart';

// Movie model (replace with your actual model)
class Movie {
  final int id;
  final String title;

  Movie({required this.id, required this.title});
}

// States
abstract class TrendingMoviesState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrendingMoviesInitial extends TrendingMoviesState {}

class TrendingMoviesLoading extends TrendingMoviesState {}

class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;

  TrendingMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  TrendingMoviesError(this.message);

  @override
  List<Object> get props => [message];
}
