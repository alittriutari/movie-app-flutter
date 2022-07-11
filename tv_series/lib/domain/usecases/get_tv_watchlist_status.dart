import '../../tv_series.dart';

class GetTvWatchlistStatus {
  final TvSeriesRepository repository;

  GetTvWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
