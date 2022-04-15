import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/features/movies/domain/entities/movie.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/repositories/tv_series_repository.dart';

class GetTvSeriesRecommendation {
  final TvSeriesRepository repository;
  GetTvSeriesRecommendation(this.repository);
  Future<Either<Failure, List<TvSeries>>> execute(int id) {
    return repository.getTvSeriesRecommendation(id);
  }
}
