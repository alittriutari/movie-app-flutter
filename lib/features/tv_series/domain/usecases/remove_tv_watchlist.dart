import 'package:dartz/dartz.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/repositories/tv_series_repository.dart';

class RemoveTvWatchlist {
  final TvSeriesRepository repository;

  RemoveTvWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TvSeriesDetail tvSeries) {
    return repository.removeWatchlist(tvSeries);
  }
}
