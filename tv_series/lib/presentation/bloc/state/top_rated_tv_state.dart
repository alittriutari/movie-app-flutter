part of '../top_rated_tv_bloc.dart';

abstract class TopRatedTvState extends Equatable {
  const TopRatedTvState();

  @override
  List<Object> get props => [];
}

class TopRatedTvInitial extends TopRatedTvState {}

class TopRatedTvLoading extends TopRatedTvState {}

class TopRatedTvLoaded extends TopRatedTvState {
  final List<TvSeries> data;

  TopRatedTvLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class TopRatedTvFailure extends TopRatedTvState {
  final Failure failure;

  TopRatedTvFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
