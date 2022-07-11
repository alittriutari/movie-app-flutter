part of '../movie_detail_bloc.dart';

abstract class MovieDetailState extends Equatable {
  const MovieDetailState();

  @override
  List<Object> get props => [];
}

class MovieDetailInitial extends MovieDetailState {}

class MovieDetailLoading extends MovieDetailState {}

class MovieDetailLoaded extends MovieDetailState {
  final MovieDetail data;

  MovieDetailLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class MovieDetailFailure extends MovieDetailState {
  final Failure failure;

  MovieDetailFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
