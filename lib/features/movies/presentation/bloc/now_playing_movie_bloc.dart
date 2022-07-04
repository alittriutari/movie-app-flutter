import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies.dart';

part 'event/now_playing_movie_event.dart';
part 'state/now_playing_movie_state.dart';

class NowPlayingMovieBloc extends Bloc<NowPlayingMovieEvent, NowPlayingMovieState> {
  final GetNowPlayingMovies _getNowPlayingMovies;
  NowPlayingMovieBloc(this._getNowPlayingMovies) : super(NowPlayingMovieInitial()) {
    on<GetNowPlayingMovieEvent>((event, emit) async {
      emit(NowPlayingMovieLoading());
      final result = await _getNowPlayingMovies.execute();
      result.fold((failure) {
        emit(NowPlayingMovieFailure(failure: failure));
      }, (data) {
        emit(NowPlayingMovieLoaded(data: data));
      });
    });
  }
}
