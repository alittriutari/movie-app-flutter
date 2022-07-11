import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

import '../../domain/entities/movie.dart';

part 'event/popular_movie_event.dart';
part 'state/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc({required this.getPopularMovies}) : super(PopularMovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();

      result.fold((failure) {
        emit(PopularMovieFailure(failure: failure));
      }, (data) {
        emit(PopularMovieLoaded(data: data));
      });
    });
  }
}
