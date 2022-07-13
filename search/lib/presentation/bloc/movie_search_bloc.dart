import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';
import 'package:search/domain/usecases/search_movies.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies searchMovies;
  MovieSearchBloc({required this.searchMovies}) : super(MovieSearchInitial()) {
    on<GetMovieSearchEvent>((event, emit) async {
      final query = event.query;
      emit(MovieSearchLoading());
      final result = await searchMovies.execute(query);
      result.fold((failure) {
        emit(MovieSearchFailure(failure: failure));
      }, (data) {
        emit(MovieSearchLoaded(data: data));
      });
    });
  }
}
