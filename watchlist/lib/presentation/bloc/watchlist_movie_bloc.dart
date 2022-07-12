import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/movie.dart';

import '../../watchlist.dart';

part 'watchlist_movie_event.dart';
part 'watchlist_movie_state.dart';

class WatchlistMovieBloc extends Bloc<WatchlistMovieEvent, WatchlistMovieState> {
  final GetWatchListStatus getWatchListStatus;
  final GetWatchlistMovies getWatchlistMovies;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  WatchlistMovieBloc({required this.getWatchListStatus, required this.getWatchlistMovies, required this.saveWatchlist, required this.removeWatchlist}) : super(WatchlistMovieInitial()) {
    on<GetWatchlistMovieEvent>((event, emit) async {
      emit(WatchlistMovieLoading());
      final result = await getWatchlistMovies.execute();

      result.fold((failure) {
        emit(WatchlistMovieFailure(failure: failure));
      }, (data) {
        emit(WatchlistMovieLoaded(data));
      });
    });
    on<AddWatchlistMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      emit(WatchlistMovieLoading());

      final result = await saveWatchlist.execute(movieDetail);
      result.fold((failure) {
        emit(WatchlistMovieFailure(failure: failure));
      }, (data) {
        emit(WatchlistMovieAction(data));
      });
    });
    on<RemoveWatchlistMovieEvent>((event, emit) async {
      final movieDetail = event.movieDetail;
      emit(WatchlistMovieLoading());
      final result = await removeWatchlist.execute(movieDetail);
      result.fold((failure) {
        emit(WatchlistMovieFailure(failure: failure));
      }, (data) {
        emit(WatchlistMovieAction(data));
      });
    });
    on<LoadWatchlistMovieEvent>((event, emit) async {
      final id = event.id;
      emit(WatchlistMovieLoading());
      final result = await getWatchListStatus.execute(id);
      emit(WatchlistMovieChanged(result));
    });
  }
}
