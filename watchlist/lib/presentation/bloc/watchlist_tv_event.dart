part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTvEvent extends WatchlistTvEvent {
  final TvSeriesDetail tvSeriesDetail;

  const AddWatchlistTvEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class RemoveWatchlistTvEvent extends WatchlistTvEvent {
  final TvSeriesDetail tvSeriesDetail;

  const RemoveWatchlistTvEvent(this.tvSeriesDetail);

  @override
  List<Object> get props => [tvSeriesDetail];
}

class GetWatchlistTvEvent extends WatchlistTvEvent {}

class LoadWatchlistTvEvent extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
