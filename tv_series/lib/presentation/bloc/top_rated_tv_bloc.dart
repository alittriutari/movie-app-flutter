import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';

import '../../domain/usecases/get_top_rated_tv.dart';
import '../../tv_series.dart';

part 'event/top_rated_tv_event.dart';
part 'state/top_rated_tv_state.dart';

class TopRatedTvBloc extends Bloc<TopRatedTvEvent, TopRatedTvState> {
  final GetTopRatedTv getTopRatedTv;
  TopRatedTvBloc({required this.getTopRatedTv}) : super(TopRatedTvInitial()) {
    on<GetTopRatedTvListEvent>((event, emit) async {
      emit(TopRatedTvLoading());
      final result = await getTopRatedTv.execute();
      result.fold((failure) {
        emit(TopRatedTvFailure(failure: failure));
      }, (data) {
        emit(TopRatedTvLoaded(data: data));
      });
    });
  }
}
