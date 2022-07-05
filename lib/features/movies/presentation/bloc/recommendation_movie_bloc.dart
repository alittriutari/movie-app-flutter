import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_recommendations.dart';

part 'recommendation_movie_event.dart';
part 'recommendation_movie_state.dart';

class RecommendationMovieBloc extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations _getMovieRecommendations;
  RecommendationMovieBloc(this._getMovieRecommendations) : super(RecommendationMovieInitial()) {
    on<GetRecommendationMovieEvent>((event, emit) async {
      final id = event.id;
      emit(RecommendationMovieLoading());
      final result = await _getMovieRecommendations.execute(id);
      result.fold((failure) {
        emit(RecommendationMovieFailure(failure: failure));
      }, (data) {
        emit(RecommendationMovieLoaded(data: data));
      });
    });
  }
}
