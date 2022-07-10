part of '../watchlist_tv_bloc.dart';

abstract class WatchlistTvState extends Equatable {
  const WatchlistTvState();

  @override
  List<Object> get props => [];
}

class WatchlistTvInitial extends WatchlistTvState {}

class WatchlistTvLoading extends WatchlistTvState {}

class WatchlistTvLoaded extends WatchlistTvState {
  final List<TvSeries> tv;

  WatchlistTvLoaded(this.tv);

  @override
  List<Object> get props => [tv];
}

class WatchlistTvAction extends WatchlistTvState {
  final String message;

  WatchlistTvAction(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistTvFailure extends WatchlistTvState {
  final Failure failure;

  WatchlistTvFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}

class WatchlistTvChanged extends WatchlistTvState {
  final bool status;

  WatchlistTvChanged(this.status);

  @override
  List<Object> get props => [status];
}
