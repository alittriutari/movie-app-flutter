import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/usecases/get_popular_movies.dart';

import '../../domain/entities/movie.dart';

part 'event/popular_movie_event.dart';
part 'state/popular_movie_state.dart';

class PopularMovieBloc extends Bloc<PopularMovieEvent, PopularMovieState> {
  final GetPopularMovies getPopularMovies;
  PopularMovieBloc({required this.getPopularMovies}) : super(PopularMovieInitial()) {
    on<GetPopularMovieEvent>((event, emit) async {
      emit(PopularMovieLoading());
      final result = await getPopularMovies.execute();
      log(result.toString());
      result.fold((failure) {
        emit(PopularMovieFailure(failure: failure));
      }, (data) {
        emit(PopularMovieLoaded(data: data));
      });
    });
  }
}
