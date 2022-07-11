import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

class GetTvEpisode {
  final TvSeriesRepository repository;

  GetTvEpisode(this.repository);

  Future<Either<Failure, List<Episode>>> execute(int id, int seasonNumber) {
    return repository.getTvEpisode(id, seasonNumber);
  }
}
