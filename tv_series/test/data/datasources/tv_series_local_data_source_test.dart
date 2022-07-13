import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TvLocalDataSource dataSource;
  late MockTvDatabaseHelper mockTvDatabaseHelper;

  setUp(() {
    mockTvDatabaseHelper = MockTvDatabaseHelper();
    dataSource = TvLocalDataSourceImpl(databaseHelper: mockTvDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success', () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvSeriesTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockTvDatabaseHelper.insertWatchlist(testTvSeriesTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success', () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvSeriesTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      // arrange
      when(mockTvDatabaseHelper.removeWatchlist(testTvSeriesTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testTvSeriesTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Tv Series Detail By Id', () {
    const tId = 1;

    test('should return Tv Series Detail Table when data is found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvSeriesById(tId)).thenAnswer((_) async => testTvMap);
      // act
      final result = await dataSource.getTvSerieById(tId);
      // assert
      expect(result, testTvSeriesTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockTvDatabaseHelper.getTvSeriesById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getTvSerieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist tv series', () {
    test('should return list of TvSeriesTable from database', () async {
      // arrange
      when(mockTvDatabaseHelper.getWatchlistTvSeries()).thenAnswer((_) async => [testTvMap]);
      // act
      final result = await dataSource.getWatchlistTvSeries();
      // assert
      expect(result, [testTvSeriesTable]);
    });
  });
}
