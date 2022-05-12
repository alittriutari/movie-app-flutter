import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/exception.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/common/network_info.dart';
import 'package:movie_app/features/movies/data/models/genre_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_model.dart';
import 'package:movie_app/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesRepositoryImpl repository;
  late MockTvSeriesRemoteDataSource mockRemoteDataSource;
  late MockTvLocalDataSource mockLocalDataSource;
  late NetworkInfo mockNetworkInfo;

  setUp(() {
    mockRemoteDataSource = MockTvSeriesRemoteDataSource();
    mockLocalDataSource = MockTvLocalDataSource();
    mockNetworkInfo = MockNetworkInfo();
    repository = TvSeriesRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      localDataSource: mockLocalDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  final tTvModel = TvSeriesModel(
      backdropPath: '/o67vkPB7dxViqhssZLp8SQEhVtD.jpg',
      firstAirDate: '2022-03-24',
      genreIds: [10759, 10765],
      id: 52814,
      name: 'Halo',
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: 'Halo',
      overview: 'overview',
      popularity: 6232.191,
      posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
      voteAverage: 8.659,
      voteCount: 601);
  final tTvSeries = TvSeries(
      backdropPath: '/o67vkPB7dxViqhssZLp8SQEhVtD.jpg',
      firstAirDate: '2022-03-24',
      genreIds: [10759, 10765],
      id: 52814,
      name: 'Halo',
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: 'Halo',
      overview: 'overview',
      popularity: 6232.191,
      posterPath: '/nJUHX3XL1jMkk8honUZnUmudFb9.jpg',
      voteAverage: 8.659,
      voteCount: 601);

  final tTvModelList = <TvSeriesModel>[tTvModel];
  final tTvSeriesList = <TvSeries>[tTvSeries];

  group('on airing tv series', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });

    test('should check if the device is online', () async {
      //arrange
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      when(mockRemoteDataSource.getOnAirTvSeries()).thenAnswer((_) async => []);

      //act
      await repository.getOnAirTvSeries();

      //assert
      verify(mockNetworkInfo.isConnected);
    });
    group('when device is online', () {
      setUp(() {
        when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
      });

      test('should return remote data when the call to remote data source is successful', () async {
        // arrange
        when(mockRemoteDataSource.getOnAirTvSeries()).thenAnswer((_) async => tTvModelList);
        // act
        final result = await repository.getOnAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnAirTvSeries());

        final resultList = result.getOrElse(() => []);
        expect(resultList, tTvSeriesList);
      });

      test('should return server failure when the call to remote data source is unsuccessful', () async {
        // arrange
        when(mockRemoteDataSource.getOnAirTvSeries()).thenThrow(ServerException());
        // act
        final result = await repository.getOnAirTvSeries();
        // assert
        verify(mockRemoteDataSource.getOnAirTvSeries());
        expect(result, equals(Left(ServerFailure(''))));
      });
    });
  });
  group('Popular Tv Series', () {
    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return tv series list when call to data source is success', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries()).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.getPopularTvSeries();
      // assert

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return server failure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getPopularTvSeries()).thenThrow(ServerException());
      // act
      final result = await repository.getPopularTvSeries();
      // assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('Get Tv Series Detail', () {
    final tId = 1;
    final tTvResponse = TvSeriesDetailResponse(
        posterPath: 'posterPath',
        backdropPath: 'backdropPath',
        episodeRunTime: [51],
        firstAirDate: '2022-02-25',
        genres: [GenreModel(id: 1, name: 'Action')],
        id: 1,
        name: 'name',
        numberOfEpisodes: 1,
        numberOfSeasons: 1,
        overview: 'overview',
        voteAverage: 1,
        voteCount: 1);

    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return Tv Serie data when the call to remote data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenAnswer((_) async => tTvResponse);
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Right(testTvDetail)));
    });

    test('should return Server Failure when the call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesDetail(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesDetail(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesDetail(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Get Tv Series Recommendations', () {
    final tTvSeriesList = <TvSeriesModel>[];
    final tId = 1;

    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return data (tv serie list) when the call is successful', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendation(tId)).thenAnswer((_) async => tTvSeriesList);
      // act
      final result = await repository.getTvSeriesRecommendation(tId);
      // assert
      verify(mockRemoteDataSource.getTvSeriesRecommendation(tId));

      final resultList = result.getOrElse(() => []);
      expect(resultList, equals(tTvSeriesList));
    });

    test('should return server failure when call to remote data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.getTvSeriesRecommendation(tId)).thenThrow(ServerException());
      // act
      final result = await repository.getTvSeriesRecommendation(tId);
      // assertbuild runner
      verify(mockRemoteDataSource.getTvSeriesRecommendation(tId));
      expect(result, equals(Left(ServerFailure(''))));
    });
  });

  group('Search Tv Series', () {
    final tQuery = 'halo';

    setUp(() {
      when(mockNetworkInfo.isConnected).thenAnswer((_) async => true);
    });
    test('should return tv serie list when call to data source is successful', () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery)).thenAnswer((_) async => tTvModelList);
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert

      final resultList = result.getOrElse(() => []);
      expect(resultList, tTvSeriesList);
    });

    test('should return ServerFailure when call to data source is unsuccessful', () async {
      // arrange
      when(mockRemoteDataSource.searchTvSeries(tQuery)).thenThrow(ServerException());
      // act
      final result = await repository.searchTvSeries(tQuery);
      // assert
      expect(result, Left(ServerFailure('')));
    });
  });

  group('save watchlist', () {
    test('should return success message when saving successful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable)).thenAnswer((_) async => 'Added to Watchlist');
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Right('Added to Watchlist'));
    });

    test('should return DatabaseFailure when saving unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.insertWatchlist(testTvSeriesTable)).thenThrow(DatabaseException('Failed to add watchlist'));
      // act
      final result = await repository.saveWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to add watchlist')));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove successful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable)).thenAnswer((_) async => 'Removed from Watchlist');
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Right('Removed from Watchlist'));
    });

    test('should return DatabaseFailure when remove unsuccessful', () async {
      // arrange
      when(mockLocalDataSource.removeWatchlist(testTvSeriesTable)).thenThrow(DatabaseException('Failed to remove watchlist'));
      // act
      final result = await repository.removeWatchlist(testTvDetail);
      // assert
      expect(result, Left(DatabaseFailure('Failed to remove watchlist')));
    });
  });

  group('get watchlist status', () {
    test('should return watch status whether data is found', () async {
      // arrange
      final tId = 1;
      when(mockLocalDataSource.getTvSerieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await repository.isAddedToWatchlist(tId);
      // assert
      expect(result, false);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of Tv Series', () async {
      // arrange
      when(mockLocalDataSource.getWatchlistTvSeries()).thenAnswer((_) async => [testTvSeriesTable]);
      // act
      final result = await repository.getWatchlistTvSeries();
      // assert
      final resultList = result.getOrElse(() => []);
      expect(resultList, [testWatchlistTvSeries]);
    });
  });
}
