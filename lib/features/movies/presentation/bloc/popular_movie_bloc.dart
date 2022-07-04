import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/usecases/get_popular_movies.dart';

import '../../domain/entities/movie.dart';

part 'popular_movie_event.dart';
part 'popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies _getPopularMovies;
  PopularMovieBloc(this._getPopularMovies) : super(PopularMovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await _getPopularMovies.execute();
      result.fold((failure) {
        emit(PopularMovieFailure(failure: failure));
      }, (data) {
        emit(PopularMovieLoaded(data: data));
      });
    });
  }
}
