import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_detail.dart';

part 'event/movie_detail_event.dart';
part 'state/movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;

  MovieDetailBloc({required this.getMovieDetail}) : super(MovieDetailInitial()) {
    on<GetMovieDetailEvent>((event, emit) async {
      final id = event.id;

      emit(MovieDetailLoading());
      final result = await getMovieDetail.execute(id);
      result.fold((failure) {
        emit(MovieDetailFailure(failure: failure));
      }, (data) {
        emit(MovieDetailLoaded(data: data));
      });
    });
  }
}
