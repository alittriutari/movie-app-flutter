import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_recommendations.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailBloc({required this.getMovieDetail, required this.getMovieRecommendations}) : super(MovieDetailInitial()) {
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
