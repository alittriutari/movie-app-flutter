import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendation.dart';

part 'event/recommendation_tv_event.dart';
part 'state/recommendation_tv_state.dart';

class RecommendationTvBloc
    extends Bloc<RecommendationTvEvent, RecommendationTvState> {
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  RecommendationTvBloc({required this.getTvSeriesRecommendation})
      : super(RecommendationTvInitial()) {
    on<GetRecommendationTvEvent>((event, emit) async {
      final id = event.id;
      emit(RecommendationTvLoading());
      final result = await getTvSeriesRecommendation.execute(id);
      result.fold((failure) {
        emit(RecommendationTvFailure(failure: failure));
      }, (data) {
        emit(RecommendationTvLoaded(data: data));
      });
    });
  }
}
