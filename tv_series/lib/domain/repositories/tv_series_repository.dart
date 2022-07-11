import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries();
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries();
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries();
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendation(int id);

  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
  Future<Either<Failure, List<Episode>>> getTvEpisode(int id, int seasonNumber);

  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries);
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeries);
  Future<bool> isAddedToWatchlist(int id);
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries();
}
