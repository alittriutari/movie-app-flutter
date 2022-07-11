import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_tv_episode.dart';
import '../../tv_series.dart';

part 'event/episode_event.dart';
part 'state/episode_state.dart';

class EpisodeBloc extends Bloc<EpisodeEvent, EpisodeState> {
  final GetTvEpisode getTvEpisode;
  EpisodeBloc({required this.getTvEpisode}) : super(EpisodeInitial()) {
    on<GetEpisodeEvent>((event, emit) async {
      final id = event.id;
      final season = event.seasonNumber;

      emit(EpisodeLoading());
      final result = await getTvEpisode.execute(id, season);
      result.fold((failure) {
        emit(EpisodeFailure(failure: failure));
      }, (data) {
        emit(EpisodeLoaded(data: data));
      });
    });
  }
}
