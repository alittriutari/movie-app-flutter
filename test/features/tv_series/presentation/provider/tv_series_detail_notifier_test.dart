import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvSeriesDetailNotifier provider;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    provider = TvSeriesDetailNotifier(
        getTvSeriesDetail: mockGetTvSeriesDetail,
        getTvSeriesRecommendation: mockGetTvSeriesRecommendation,
        getTvWatchlistStatus: mockGetTvWatchlistStatus,
        saveTvWatchlist: mockSaveTvWatchlist,
        removeTvWatchlist: mockRemoveTvWatchlist)
      ..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;
  final tTvSerie = TvSeries(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 5.0,
      posterPath: 'posterPath',
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeries = <TvSeries>[tTvSerie];

  void _arrangeUsecase() {
    when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
    when(mockGetTvSeriesRecommendation.execute(tId)).thenAnswer((_) async => Right(tTvSeries));
  }

  group('Get Tv Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesDetail.execute(tId));
      verify(mockGetTvSeriesRecommendation.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTvDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation tv series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendation, tTvSeries);
    });
  });

  group('Get Tv Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      verify(mockGetTvSeriesRecommendation.execute(tId));
      expect(provider.tvSeriesRecommendation, tTvSeries);
    });

    test('should update recommendation state when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendation, tTvSeries);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
      when(mockGetTvSeriesRecommendation.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.recommendationState, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetTvWatchlistStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => Right('Success'));
      when(mockGetTvWatchlistStatus.execute(testTvDetail.id)).thenAnswer((_) async => true);
      // act
      await provider.addWatchList(testTvDetail);
      // assert
      verify(mockSaveTvWatchlist.execute(testTvDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => Right('Removed'));
      when(mockGetTvWatchlistStatus.execute(testTvDetail.id)).thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTvDetail);
      // assert
      verify(mockRemoveTvWatchlist.execute(testTvDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetTvWatchlistStatus.execute(testTvDetail.id)).thenAnswer((_) async => true);
      // act
      await provider.addWatchList(testTvDetail);
      // assert
      verify(mockGetTvWatchlistStatus.execute(testTvDetail.id));
      expect(provider.isAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetTvWatchlistStatus.execute(testTvDetail.id)).thenAnswer((_) async => false);
      // act
      await provider.addWatchList(testTvDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTvSeriesRecommendation.execute(tId)).thenAnswer((_) async => Right(tTvSeries));
      // act
      await provider.fetchTvSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
