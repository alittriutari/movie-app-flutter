import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/features/search/domain/usecases/search_tv_series.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTvSeries searchTvSeries;
  TvSearchBloc({required this.searchTvSeries}) : super(TvSearchInitial()) {
    on<GetTvSearchEvent>((event, emit) async {
      final query = event.query;
      emit(TvSearchLoading());
      final result = await searchTvSeries.execute(query);
      result.fold((failure) {
        emit(TvSearchFailure(failure: failure));
      }, (data) {
        emit(TvSearchLoaded(data: data));
      });
    });
  }
}
