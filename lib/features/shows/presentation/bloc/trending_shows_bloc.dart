import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:Piratecoin/features/shows/domain/entities/show.dart';
import 'package:Piratecoin/features/shows/domain/repositories/show_repository.dart';

/// ─────────────────────────────
/// EVENTS
/// ─────────────────────────────
abstract class TrendingShowsEvent extends Equatable {
  const TrendingShowsEvent();

  @override
  List<Object?> get props => [];
}

class FetchTrendingShows extends TrendingShowsEvent {
  const FetchTrendingShows();
}

/// ─────────────────────────────
/// STATES
/// ─────────────────────────────
abstract class TrendingShowsState extends Equatable {
  const TrendingShowsState();

  @override
  List<Object?> get props => [];
}

class TrendingShowsInitial extends TrendingShowsState {
  const TrendingShowsInitial();
}

class TrendingShowsLoading extends TrendingShowsState {
  const TrendingShowsLoading();
}

class TrendingShowsLoaded extends TrendingShowsState {
  final List<Show> shows;

  const TrendingShowsLoaded(this.shows);

  @override
  List<Object?> get props => [shows];
}

class TrendingShowsError extends TrendingShowsState {
  final String message;

  const TrendingShowsError(this.message);

  @override
  List<Object?> get props => [message];
}

/// ─────────────────────────────
/// BLOC
/// ─────────────────────────────
class TrendingShowsBloc extends Bloc<TrendingShowsEvent, TrendingShowsState> {
  final ShowRepository showRepository;

  TrendingShowsBloc({required this.showRepository})
      : super(const TrendingShowsInitial()) {
    on<FetchTrendingShows>(_onFetchTrendingShows);
  }

  Future<void> _onFetchTrendingShows(
    FetchTrendingShows event,
    Emitter<TrendingShowsState> emit,
  ) async {
    emit(const TrendingShowsLoading());
    try {
      final Shows = await showRepository.fetchTrendingShows();
      emit(TrendingShowsLoaded(Shows));
    } catch (e) {
      emit(TrendingShowsError('Failed to fetch trending Shows: $e'));
    }
  }
}
