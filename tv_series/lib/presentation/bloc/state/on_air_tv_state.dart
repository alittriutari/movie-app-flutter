part of '../on_air_tv_bloc.dart';

abstract class OnAirTvState extends Equatable {
  const OnAirTvState();

  @override
  List<Object> get props => [];
}

class OnAirTvInitial extends OnAirTvState {}

class OnAirTvLoading extends OnAirTvState {}

class OnAirTvLoaded extends OnAirTvState {
  final List<TvSeries> data;

  const OnAirTvLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class OnAirTvFailure extends OnAirTvState {
  final Failure failure;

  const OnAirTvFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
