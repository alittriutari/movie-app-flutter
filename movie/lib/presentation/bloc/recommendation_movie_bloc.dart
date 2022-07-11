import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/movie.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';

part 'event/recommendation_movie_event.dart';
part 'state/recommendation_movie_state.dart';

class RecommendationMovieBloc extends Bloc<RecommendationMovieEvent, RecommendationMovieState> {
  final GetMovieRecommendations getMovieRecommendations;
  RecommendationMovieBloc({required this.getMovieRecommendations}) : super(RecommendationMovieInitial()) {
    on<GetRecommendationMovieEvent>((event, emit) async {
      final id = event.id;
      emit(RecommendationMovieLoading());
      final result = await getMovieRecommendations.execute(id);
      result.fold((failure) {
        emit(RecommendationMovieFailure(failure: failure));
      }, (data) {
        emit(RecommendationMovieLoaded(data: data));
      });
    });
  }
}
