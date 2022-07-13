part of '../now_playing_movie_bloc.dart';

abstract class NowPlayingMovieState extends Equatable {
  const NowPlayingMovieState();

  @override
  List<Object> get props => [];
}

class NowPlayingMovieInitial extends NowPlayingMovieState {}

class NowPlayingMovieLoading extends NowPlayingMovieState {}

class NowPlayingMovieLoaded extends NowPlayingMovieState {
  final List<Movie> data;

  const NowPlayingMovieLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class NowPlayingMovieFailure extends NowPlayingMovieState {
  final Failure failure;

  const NowPlayingMovieFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
