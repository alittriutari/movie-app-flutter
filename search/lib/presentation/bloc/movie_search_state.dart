part of 'movie_search_bloc.dart';

abstract class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object> get props => [];
}

class MovieSearchInitial extends MovieSearchState {}

class MovieSearchLoading extends MovieSearchState {}

class MovieSearchLoaded extends MovieSearchState {
  final List<Movie> data;

  MovieSearchLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class MovieSearchFailure extends MovieSearchState {
  final Failure failure;

  MovieSearchFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
