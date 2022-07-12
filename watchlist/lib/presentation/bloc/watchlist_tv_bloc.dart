import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_series/tv_series.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final GetWatchListTv getWatchListTv;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;
  WatchlistTvBloc({required this.getTvWatchlistStatus, required this.getWatchListTv, required this.saveTvWatchlist, required this.removeTvWatchlist}) : super(WatchlistTvInitial()) {
    on<GetWatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchListTv.execute();

      result.fold((failure) {
        emit(WatchlistTvFailure(failure: failure));
      }, (data) {
        emit(WatchlistTvLoaded(data));
      });
    });
    on<AddWatchlistTvEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      emit(WatchlistTvLoading());

      final result = await saveTvWatchlist.execute(tvSeriesDetail);
      result.fold((failure) {
        emit(WatchlistTvFailure(failure: failure));
      }, (data) {
        emit(WatchlistTvAction(data));
      });
    });
    on<RemoveWatchlistTvEvent>((event, emit) async {
      final tvSeriesDetail = event.tvSeriesDetail;
      emit(WatchlistTvLoading());
      final result = await removeTvWatchlist.execute(tvSeriesDetail);
      result.fold((failure) {
        emit(WatchlistTvFailure(failure: failure));
      }, (data) {
        emit(WatchlistTvAction(data));
      });
    });
    on<LoadWatchlistTvEvent>((event, emit) async {
      final id = event.id;
      emit(WatchlistTvLoading());
      final result = await getTvWatchlistStatus.execute(id);
      emit(WatchlistTvChanged(result));
    });
  }
}
