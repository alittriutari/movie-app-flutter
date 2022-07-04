import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies.dart';

part 'top_rated_movie_event.dart';
part 'top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies _getTopRatedMovies;
  TopRatedMovieBloc(this._getTopRatedMovies) : super(TopRatedMovieInitial()) {
    on<GetTopRatedMovieList>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await _getTopRatedMovies.execute();
      result.fold((failure) {
        emit(TopRatedMovieFailure(failure: failure));
      }, (data) {
        emit(TopRatedMovieLoaded(data: data));
      });
    });
  }
}
