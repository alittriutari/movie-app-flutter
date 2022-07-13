import 'package:bloc/bloc.dart';
import 'package:core/core.dart';
import 'package:equatable/equatable.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/domain/usecases/get_tv_watchlist_status.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv.dart';
import 'package:watchlist/domain/usecases/remove_tv_watchlist.dart';
import 'package:watchlist/domain/usecases/save_tv_watchlist.dart';

part 'watchlist_tv_event.dart';
part 'watchlist_tv_state.dart';

class WatchlistTvBloc extends Bloc<WatchlistTvEvent, WatchlistTvState> {
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final GetWatchListTv getWatchlistTv;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;
  WatchlistTvBloc({required this.getTvWatchlistStatus, required this.getWatchlistTv, required this.saveTvWatchlist, required this.removeTvWatchlist}) : super(WatchlistTvInitial()) {
    on<GetWatchlistTvEvent>((event, emit) async {
      emit(WatchlistTvLoading());
      final result = await getWatchlistTv.execute();

      result.fold((failure) {
        emit(WatchlistTvFailure(failure: failure));
      }, (data) {
        emit(WatchlistTvLoaded(data));
      });
    });
    on<AddWatchlistTvEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      emit(WatchlistTvLoading());

      final result = await saveTvWatchlist.execute(tvDetail);
      result.fold((failure) {
        emit(WatchlistTvFailure(failure: failure));
      }, (data) {
        emit(WatchlistTvAction(data));
      });
    });
    on<RemoveWatchlistTvEvent>((event, emit) async {
      final tvDetail = event.tvDetail;
      emit(WatchlistTvLoading());
      final result = await removeTvWatchlist.execute(tvDetail);
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
