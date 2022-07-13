part of '../tv_detail_bloc.dart';

abstract class TvDetailState extends Equatable {
  const TvDetailState();

  @override
  List<Object> get props => [];
}

class TvDetailInitial extends TvDetailState {}

class TvDetailLoading extends TvDetailState {}

class TvDetailLoaded extends TvDetailState {
  final TvSeriesDetail data;

  const TvDetailLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class TvDetailFailure extends TvDetailState {
  final Failure failure;

  const TvDetailFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
