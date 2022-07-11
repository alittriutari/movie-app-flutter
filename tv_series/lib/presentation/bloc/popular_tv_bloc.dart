import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_popular_tv_series.dart';
import '../../tv_series.dart';

part 'event/popular_tv_event.dart';
part 'state/popular_tv_state.dart';

class PopularTvBloc extends Bloc<PopularTvEvent, PopularTvState> {
  final GetPopularTvSeries getPopularTvSeries;
  PopularTvBloc({required this.getPopularTvSeries}) : super(PopularTvInitial()) {
    on<GetPopularTvListEvent>((event, emit) async {
      emit(PopularTvLoading());
      final result = await getPopularTvSeries.execute();
      result.fold((failure) {
        emit(PopularTvFailure(failure: failure));
      }, (data) {
        emit(PopularTvLoaded(data: data));
      });
    });
  }
}
