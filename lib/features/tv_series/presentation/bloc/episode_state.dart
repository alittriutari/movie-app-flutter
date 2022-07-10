part of 'episode_bloc.dart';

abstract class EpisodeState extends Equatable {
  const EpisodeState();

  @override
  List<Object> get props => [];
}

class EpisodeInitial extends EpisodeState {}

class EpisodeLoading extends EpisodeState {}

class EpisodeLoaded extends EpisodeState {
  final List<Episode> data;

  EpisodeLoaded({required this.data});

  @override
  List<Object> get props => [data];
}

class EpisodeFailure extends EpisodeState {
  final Failure failure;

  EpisodeFailure({required this.failure});

  @override
  List<Object> get props => [failure];
}
