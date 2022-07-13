part of '../recommendation_tv_bloc.dart';

abstract class RecommendationTvState extends Equatable {
  const RecommendationTvState();

  @override
  List<Object> get props => [];
}

class RecommendationTvInitial extends RecommendationTvState {}

class RecommendationTvLoading extends RecommendationTvState {}

class RecommendationTvLoaded extends RecommendationTvState {
  final List<TvSeries> data;

  const RecommendationTvLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class RecommendationTvFailure extends RecommendationTvState {
  final Failure failure;

  const RecommendationTvFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
