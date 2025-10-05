import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Piratecoin/features/movies/domain/entities/movie.dart';
import 'package:Piratecoin/features/movies/domain/repositories/movie_repository.dart';

/// ─────────────────────────────
/// EVENTS
/// ─────────────────────────────
abstract class TrendingMoviesEvent extends Equatable {
  const TrendingMoviesEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingMovies extends TrendingMoviesEvent {
  const FetchTrendingMovies();
}

/// ─────────────────────────────
/// STATES
/// ─────────────────────────────
abstract class TrendingMoviesState extends Equatable {
  const TrendingMoviesState();

  @override
  List<Object?> get props => [];
}

class TrendingMoviesInitial extends TrendingMoviesState {
  const TrendingMoviesInitial();
}

class TrendingMoviesLoading extends TrendingMoviesState {
  const TrendingMoviesLoading();
}

class TrendingMoviesLoaded extends TrendingMoviesState {
  final List<Movie> movies;

  const TrendingMoviesLoaded(this.movies);

  @override
  List<Object?> get props => [movies];
}

class TrendingMoviesError extends TrendingMoviesState {
  final String message;

  const TrendingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}

/// ─────────────────────────────
/// BLOC
/// ─────────────────────────────
class TrendingMoviesBloc
    extends Bloc<TrendingMoviesEvent, TrendingMoviesState> {
  final MovieRepository movieRepository;

  TrendingMoviesBloc({required this.movieRepository})
      : super(const TrendingMoviesInitial()) {
    on<FetchTrendingMovies>(_onFetchTrendingMovies);
  }

  Future<void> _onFetchTrendingMovies(
    FetchTrendingMovies event,
    Emitter<TrendingMoviesState> emit,
  ) async {
    emit(const TrendingMoviesLoading());
    try {
      final movies = await movieRepository.fetchTrendingMovies();
      emit(TrendingMoviesLoaded(movies));
    } catch (e) {
      emit(TrendingMoviesError('Failed to fetch trending movies: $e'));
    }
  }
}
