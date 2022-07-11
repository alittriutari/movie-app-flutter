import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

class GetTvSeriesRecommendation {
  final TvSeriesRepository repository;
  GetTvSeriesRecommendation(this.repository);
  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendation(id);
  }
}
