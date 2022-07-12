part of '../popular_tv_bloc.dart';

abstract class PopularTvState extends Equatable {
  const PopularTvState();

  @override
  List<Object> get props => [];
}

class PopularTvInitial extends PopularTvState {}

class PopularTvLoading extends PopularTvState {}

class PopularTvLoaded extends PopularTvState {
  final List<TvSeries> data;

  const PopularTvLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class PopularTvFailure extends PopularTvState {
  final Failure failure;

  const PopularTvFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
