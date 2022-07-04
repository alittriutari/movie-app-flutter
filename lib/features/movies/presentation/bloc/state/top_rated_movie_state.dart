part of '../top_rated_movie_bloc.dart';

abstract class TopRatedMovieState extends Equatable {
  const TopRatedMovieState();

  @override
  List<Object> get props => [];
}

class TopRatedMovieInitial extends TopRatedMovieState {}

class TopRatedMovieLoading extends TopRatedMovieState {}

class TopRatedMovieLoaded extends TopRatedMovieState {
  final List<Movie> data;

  TopRatedMovieLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class TopRatedMovieFailure extends TopRatedMovieState {
  final Failure failure;

  TopRatedMovieFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
