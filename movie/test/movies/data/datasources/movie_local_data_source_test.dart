import 'package:core/core.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/movie.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late MovieLocalDataSourceImpl dataSource;
  late MockMovieDatabaseHelper mockMovieDatabaseHelper;

  setUp(() {
    mockMovieDatabaseHelper = MockMovieDatabaseHelper();
    dataSource = MovieLocalDataSourceImpl(databaseHelper: mockMovieDatabaseHelper);
  });

  group('save watchlist', () {
    test('should return success message when insert to database is success', () async {
      // arrange
      when(mockMovieDatabaseHelper.insertWatchlist(testMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(result, 'Added to Watchlist');
    });

    test('should throw DatabaseException when insert to database is failed', () async {
      // arrange
      when(mockMovieDatabaseHelper.insertWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.insertWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('remove watchlist', () {
    test('should return success message when remove from database is success', () async {
      // arrange
      when(mockMovieDatabaseHelper.removeWatchlist(testMovieTable)).thenAnswer((_) async => 1);
      // act
      final result = await dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(result, 'Removed from Watchlist');
    });

    test('should throw DatabaseException when remove from database is failed', () async {
      // arrange
      when(mockMovieDatabaseHelper.removeWatchlist(testMovieTable)).thenThrow(Exception());
      // act
      final call = dataSource.removeWatchlist(testMovieTable);
      // assert
      expect(() => call, throwsA(isA<DatabaseException>()));
    });
  });

  group('Get Movie Detail By Id', () {
    const tId = 1;

    test('should return Movie Detail Table when data is found', () async {
      // arrange
      when(mockMovieDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => testMovieMap);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, testMovieTable);
    });

    test('should return null when data is not found', () async {
      // arrange
      when(mockMovieDatabaseHelper.getMovieById(tId)).thenAnswer((_) async => null);
      // act
      final result = await dataSource.getMovieById(tId);
      // assert
      expect(result, null);
    });
  });

  group('get watchlist movies', () {
    test('should return list of MovieTable from database', () async {
      // arrange
      when(mockMovieDatabaseHelper.getWatchlistMovies()).thenAnswer((_) async => [testMovieMap]);
      // act
      final result = await dataSource.getWatchlistMovies();
      // assert
      expect(result, [testMovieTable]);
    });
  });

  group('cache now playing movies', () {
    test('should call database helper to save data', () async {
      //arrange
      when(mockMovieDatabaseHelper.clearCache('now playing')).thenAnswer((_) async => 1);

      //act
      await dataSource.cacheNowPlayingMovies([testMovieCache]);

      //assert
      verify(mockMovieDatabaseHelper.clearCache('now playing'));
      verify(mockMovieDatabaseHelper.insertCacheTransaction([testMovieCache], 'now playing'));
    });

    test('should return list of movies from db when data exist', () async {
      // arrange
      when(mockMovieDatabaseHelper.getCacheMovies('now playing')).thenAnswer((_) async => [testMovieCacheMap]);
      // act
      final result = await dataSource.getCachedNowPlayingMovies();
      // assert
      expect(result, [testMovieCache]);
    });

    test('should throw CacheException when cache data is not exist', () async {
      // arrange
      when(mockMovieDatabaseHelper.getCacheMovies('now playing')).thenAnswer((_) async => []);
      // act
      final call = dataSource.getCachedNowPlayingMovies();
      // assert
      expect(() => call, throwsA(isA<CacheException>()));
    });
  });
}
