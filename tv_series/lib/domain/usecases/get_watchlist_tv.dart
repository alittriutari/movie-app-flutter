import 'package:core/core.dart';
import 'package:dartz/dartz.dart';

import '../../tv_series.dart';

class GetWatchListTv {
  final TvSeriesRepository _repository;
  GetWatchListTv(this._repository);

  Future<Either<Failure, List<TvSeries>>> execute() {
    return _repository.getWatchlistTvSeries();
  }
}
