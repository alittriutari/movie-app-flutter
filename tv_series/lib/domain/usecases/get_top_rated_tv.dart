import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

class GetTopRatedTv {
  final TvSeriesRepository repository;

  GetTopRatedTv(this.repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return repository.getTopRatedTvSeries();
  }
}
