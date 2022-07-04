part of '../popular_movie_bloc.dart';

abstract class PopularMovieState extends Equatable {
  const PopularMovieState();

  @override
  List<Object> get props => [];
}

class PopularMovieInitial extends PopularMovieState {}

class PopularMovieLoading extends PopularMovieState {}

class PopularMovieLoaded extends PopularMovieState {
  final List<Movie> data;

  PopularMovieLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class PopularMovieFailure extends PopularMovieState {
  final Failure failure;

  PopularMovieFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
