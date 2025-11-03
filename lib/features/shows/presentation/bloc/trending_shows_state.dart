import 'package:equatable/equatable.dart';

// Show model (replace with your actual model)
class Show {
  final int id;
  final String title;

  Show({required this.id, required this.title});
}

// States
abstract class TrendingShowsState extends Equatable {
  @override
  List<Object> get props => [];
}

class TrendingShowsInitial extends TrendingShowsState {}

class TrendingShowsLoading extends TrendingShowsState {}

class TrendingShowsLoaded extends TrendingShowsState {
  final List<Show> Shows;

  TrendingShowsLoaded(this.Shows);

  @override
  List<Object> get props => [Shows];
}

class TrendingShowsError extends TrendingShowsState {
  final String message;

  TrendingShowsError(this.message);

  @override
  List<Object> get props => [message];
}
