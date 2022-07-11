import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_episode.dart';

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
