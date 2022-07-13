import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'event/now_playing_movie_event.dart';
part 'state/now_playing_movie_state.dart';

class NowPlayingMovieBloc
    extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  NowPlayingMovieBloc({required this.getNowPlayingMovies})
      : super(NowPlayingMovieInitial()) {
    on<GetNowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingMovieFailure(failure: failure));
      }, (data) {
        emit(NowPlayingMovieLoaded(data: data));
      });
    });
  }
}
