import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';

part 'event/on_air_tv_event.dart';
part 'state/on_air_tv_state.dart';

class OnAirTvBloc extends Bloc<OnAirTvEvent, OnAirTvState> {
  final GetOnAirTvSeries getOnAirTvSeries;
  OnAirTvBloc({required this.getOnAirTvSeries}) : super(OnAirTvInitial()) {
    on<GetOnAirTvListEvent>((event, emit) async {
      emit(OnAirTvLoading());
      final result = await getOnAirTvSeries.execute();
      result.fold((failure) {
        emit(OnAirTvFailure(failure: failure));
      }, (data) {
        emit(OnAirTvLoaded(data: data));
      });
    });
  }
}
