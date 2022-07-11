import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

class GetOnAirTvSeries {
  final TvSeriesRepository repository;

  GetOnAirTvSeries(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getOnAirTvSeries();
  }
}
