import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_tv_series_detail.dart';
import '../../tv_series.dart';

part 'event/tv_detail_event.dart';
part 'state/tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  final GetTvSeriesDetail getTvSeriesDetail;
  TvDetailBloc({required this.getTvSeriesDetail}) : super(TvDetailInitial()) {
    on<GetTvDetailEvent>((event, emit) async {
      final id = event.id;

      emit(TvDetailLoading());
      final result = await getTvSeriesDetail.execute(id);
      result.fold((failure) {
        emit(TvDetailFailure(failure: failure));
      }, (data) {
        emit(TvDetailLoaded(data: data));
      });
    });
  }
}
