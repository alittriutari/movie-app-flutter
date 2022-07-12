import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class GetTvEpisode {
  final TvSeriesRepository repository;

  GetTvEpisode(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getTvEpisode(id, seasonNumber);
  }
}
