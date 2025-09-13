import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

// Events
abstract class TrendingShowsEvent extends Equatable {
  const TrendingShowsEvent();

  @override
  List<Object> get props => [];
}

class FetchTrendingShows extends TrendingShowsEvent {}

// States
abstract class TrendingShowsState extends Equatable {
  const TrendingShowsState();

  @override
  List<Object> get props => [];
}

class TrendingShowsInitial extends TrendingShowsState {}

class TrendingShowsLoading extends TrendingShowsState {}

class TrendingShowsLoaded extends TrendingShowsState {
  final List<dynamic> shows; // Replace dynamic with your Show model

  const TrendingShowsLoaded(this.shows);

  @override
  List<Object> get props => [shows];
}

class TrendingShowsError extends TrendingShowsState {
  final String message;

  const TrendingShowsError(this.message);

  @override
  List<Object> get props => [message];
}

// Bloc
class TrendingShowsBloc extends Bloc<TrendingShowsEvent, TrendingShowsState> {
  // final ShowRepository showRepository; // Inject your repository

  TrendingShowsBloc(/*this.showRepository*/) : super(TrendingShowsInitial()) {
    on<FetchTrendingShows>(_onFetchTrendingShows);
  }

  Future<void> _onFetchTrendingShows(
    FetchTrendingShows event,
    Emitter<TrendingShowsState> emit,
  ) async {
    emit(TrendingShowsLoading());
    try {
      // final shows = await showRepository.fetchTrendingShows();
      final shows = []; // Replace with actual fetch logic
      emit(TrendingShowsLoaded(shows));
    } catch (e) {
      emit(TrendingShowsError(e.toString()));
    }
  }
}
