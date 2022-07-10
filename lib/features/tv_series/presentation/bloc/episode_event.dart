part of 'episode_bloc.dart';

abstract class EpisodeEvent extends Equatable {
  const EpisodeEvent();

  @override
  List<Object> get props => [];
}

class GetEpisodeEvent extends EpisodeEvent {
  final int id;
  final int seasonNumber;

  GetEpisodeEvent({required this.id, required this.seasonNumber});

  @override
  List<Object> get props => [id];
}
