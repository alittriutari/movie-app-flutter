part of 'watchlist_movie_bloc.dart';

abstract class WatchlistMovieEvent extends Equatable {
  const WatchlistMovieEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistMovieEvent extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const AddWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class RemoveWatchlistMovieEvent extends WatchlistMovieEvent {
  final MovieDetail movieDetail;

  const RemoveWatchlistMovieEvent(this.movieDetail);

  @override
  List<Object> get props => [movieDetail];
}

class GetWatchlistMovieEvent extends WatchlistMovieEvent {}

class LoadWatchlistMovieEvent extends WatchlistMovieEvent {
  final int id;

  const LoadWatchlistMovieEvent(this.id);

  @override
  List<Object> get props => [id];
}
