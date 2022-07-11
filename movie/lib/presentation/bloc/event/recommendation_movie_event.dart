part of '../recommendation_movie_bloc.dart';

abstract class RecommendationMovieEvent extends Equatable {
  const RecommendationMovieEvent();

  @override
  List<Object> get props => [];
}

class GetRecommendationMovieEvent extends RecommendationMovieEvent {
  final int id;

  GetRecommendationMovieEvent(this.id);
  @override
  List<Object> get props => [id];
}
