import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Movie model (replace with your actual model)
class Movie {
  final int id;
  final String title;

  Movie({required this.id, required this.title});
}

// Events
abstract class TrendingMoviesEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchTrendingMovies extends TrendingMoviesEvent {}

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

// Bloc
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  TrendingMoviesBloc() : super(TrendingMoviesInitial()) {
    on<FetchTrendingMovies>(_onFetchTrendingMovies);
  }

  Future<void> _onFetchTrendingMovies(
    FetchTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(TrendingMoviesLoading());
    try {
      // Replace with your actual data fetching logic
      await Future.delayed(const Duration(seconds: 2));
      final movies = List.generate(
        10,
        (index) => Movie(id: index, title: 'Movie $index'),
      );
      emit(TrendingMoviesLoaded(movies));
    } catch (e) {
      emit(TrendingMoviesError('Failed to fetch trending movies'));
    }
  }
}
