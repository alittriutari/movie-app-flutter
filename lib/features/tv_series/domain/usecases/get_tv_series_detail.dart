import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvSeriesDetail {
  final TvSeriesRepository repository;

  GetTvSeriesDetail(this.repository);
  Future<Either<Failure, TvSeriesDetail>> execute(int id) {
    return repository.getTvSeriesDetail(id);
  }
}
