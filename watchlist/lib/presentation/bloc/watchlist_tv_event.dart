part of 'watchlist_tv_bloc.dart';

abstract class WatchlistTvEvent extends Equatable {
  const WatchlistTvEvent();

  @override
  List<Object> get props => [];
}

class AddWatchlistTvEvent extends WatchlistTvEvent {
  final TvSeriesDetail tvDetail;

  const AddWatchlistTvEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class RemoveWatchlistTvEvent extends WatchlistTvEvent {
  final TvSeriesDetail tvDetail;

  const RemoveWatchlistTvEvent(this.tvDetail);

  @override
  List<Object> get props => [tvDetail];
}

class GetWatchlistTvEvent extends WatchlistTvEvent {}

class LoadWatchlistTvEvent extends WatchlistTvEvent {
  final int id;

  const LoadWatchlistTvEvent(this.id);

  @override
  List<Object> get props => [id];
}
