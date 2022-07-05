part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieState extends Equatable {
  const WatchlistMovieState();

  @override
  List<Object> get props => [];
}

class WatchlistMovieInitial extends WatchlistMovieState {}

class WatchlistMovieLoading extends WatchlistMovieState {}

class WatchlistMovieLoaded extends WatchlistMovieState {
  final List<Movie> movie;

  WatchlistMovieLoaded(this.movie);

  @override
  List<Object> get props => [movie];
}

class WatchlistMovieAction extends WatchlistMovieState {
  final String message;

  WatchlistMovieAction(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistMovieFailure extends WatchlistMovieState {
  final Failure failure;

  WatchlistMovieFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

class WatchlistMovieChanged extends WatchlistMovieState {
  final bool status;

  WatchlistMovieChanged(this.status);

  @override
  List<Object> get props => [status];
}
