import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

part 'event/top_rated_movie_event.dart';
part 'state/top_rated_movie_state.dart';

class TopRatedMovieBloc extends Bloc<TopRatedMovieEvent, TopRatedMovieState> {
  final GetTopRatedMovies getTopRatedMovies;
  TopRatedMovieBloc({required this.getTopRatedMovies})
      : super(TopRatedMovieInitial()) {
    on<GetTopRatedMovieListEvent>((event, emit) async {
      emit(TopRatedMovieLoading());
      final result = await getTopRatedMovies.execute();
      result.fold((failure) {
        emit(TopRatedMovieFailure(failure: failure));
      }, (data) {
        emit(TopRatedMovieLoaded(data: data));
      });
    });
  }
}
