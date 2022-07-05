part of 'recommendation_movie_bloc.dart';

abstract class RecommendationMovieState extends Equatable {
  const RecommendationMovieState();

  @override
  List<Object> get props => [];
}

class RecommendationMovieInitial extends RecommendationMovieState {}

class RecommendationMovieLoading extends RecommendationMovieState {}

class RecommendationMovieLoaded extends RecommendationMovieState {
  final List<Movie> data;

  RecommendationMovieLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class RecommendationMovieFailure extends RecommendationMovieState {
  final Failure failure;

  RecommendationMovieFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
