import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

class TvSeriesRepositoryImpl implements TvSeriesRepository {
  final TvSeriesRemoteDataSource remoteDataSource;
  final TvLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  TvSeriesRepositoryImpl({required this.remoteDataSource, required this.localDataSource, required this.networkInfo});

  @override
  Future<Either<Failure, List<TvSeries>>> getOnAirTvSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getOnAirTvSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, TvSeriesDetail>> getTvSeriesDetail(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvSeriesDetail(id);
        return Right(result.toEntity());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTopRatedTvSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTopRatedTvSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getTvSeriesRecommendation(int id) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvSeriesRecommendation(id);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getPopularTvSeries() async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getPopularTvSeries();
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> searchTvSeries(String query) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.searchTvSeries(query);
        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<Episode>>> getTvEpisode(int id, int seasonNumber) async {
    if (await networkInfo.isConnected) {
      try {
        final result = await remoteDataSource.getTvEpisode(id, seasonNumber);

        return Right(result.map((model) => model.toEntity()).toList());
      } on ServerException {
        return Left(ServerFailure(''));
      }
    }
    return Left(ServerFailure(''));
  }

  @override
  Future<Either<Failure, List<TvSeries>>> getWatchlistTvSeries() async {
    final result = await localDataSource.getWatchlistTvSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }

  @override
  Future<bool> isAddedToWatchlist(int id) async {
    final result = await localDataSource.getTvSerieById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, String>> saveWatchlist(TvSeriesDetail tvSeries) async {
    try {
      final result = await localDataSource.insertWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeWatchlist(TvSeriesDetail tvSeries) async {
    try {
      final result = await localDataSource.removeWatchlist(TvSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }
}
