import 'package:movie_app/features/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvWatchlistStatus {
  final TvSeriesRepository repository;

  GetTvWatchlistStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isAddedToWatchlist(id);
  }
}
