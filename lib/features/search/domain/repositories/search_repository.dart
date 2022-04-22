import 'package:dartz/dartz.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';

abstract class SearchRepository {
  Future<Either<Failure, List<Movie>>> searchMovies(String query);
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query);
}
