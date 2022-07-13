part of 'tv_search_bloc.dart';

abstract class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object> get props => [];
}

class TvSearchInitial extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchLoaded extends TvSearchState {
  final List<TvSeries> data;

  const TvSearchLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class TvSearchFailure extends TvSearchState {
  final Failure failure;

  const TvSearchFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
