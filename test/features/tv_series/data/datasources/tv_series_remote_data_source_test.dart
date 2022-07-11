import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/api_url.dart';
import 'package:movie_app/common/exception.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie_app/features/tv_series/data/models/episode_response.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_response.dart';

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockIOClient mockIOClient;

  setUp(() {
    mockIOClient = MockIOClient();
    dataSource = TvSeriesRemoteDataSourceImpl(ioClient: mockIOClient);
  });

  group('get on the air tv series', () {
    final tOnAirTvSeriesList = TvSeriesResponse.fromJson(jsonDecode(readJson('dummy_data/on_air_now_tv_series.json'))).tvSeriesList;

    test('should return list of Tv Series Model when the response code is 200', () async {
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesOnAir)))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_air_now_tv_series.json'), 200));

      final result = await dataSource.getOnAirTvSeries();

      expect(result, equals(tOnAirTvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesOnAir))).thenAnswer((_) async => http.Response('Not found', 404));

      final call = dataSource.getOnAirTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get popular tv series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/popular_tv.json'))).tvSeriesList;

    test('should return list of tv series when response is success (200)', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesPopular))).thenAnswer((_) async => http.Response(readJson('dummy_data/popular_tv.json'), 200));
      // act
      final result = await dataSource.getPopularTvSeries();
      // assert
      expect(result, tTvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesPopular))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getPopularTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get top rated tv series', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/top_rated_tv.json'))).tvSeriesList;

    test('should return list of tv series when response is success (200)', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesTopRated)))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/top_rated_tv.json'), 200));
      // act
      final result = await dataSource.getTopRatedTvSeries();
      // assert
      expect(result, tTvSeriesList);
    });

    test('should throw a ServerException when the response code is 404 or other', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesTopRated))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTopRatedTvSeries();
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series detail', () {
    final tId = 1;
    final tTvSeriesDetail = TvSeriesDetailResponse.fromJson(json.decode(readJson('dummy_data/tv_detail.json')));

    test('should return tv series detail when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesDetail(tId))))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_detail.json'), 200));
      // act
      final result = await dataSource.getTvSeriesDetail(tId);
      // assert
      expect(result, equals(tTvSeriesDetail));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesDetail(tId)))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesDetail(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series recommendations', () {
    final tTvSeriesList = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/tv_recommendations.json'))).tvSeriesList;
    final tId = 1;

    test('should return list of tv series model when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesRecommendation(tId))))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/tv_recommendations.json'), 200));
      // act
      final result = await dataSource.getTvSeriesRecommendation(tId);
      // assert
      expect(result, equals(tTvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesRecommendation(tId)))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvSeriesRecommendation(tId);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('search tv series', () {
    final tSearchResult = TvSeriesResponse.fromJson(json.decode(readJson('dummy_data/search_squid_game_tv.json'))).tvSeriesList;
    final tQuery = 'squid game';

    test('should return list of tv series when response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.searchTvSeries(tQuery))))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/search_squid_game_tv.json'), 200));
      // act
      final result = await dataSource.searchTvSeries(tQuery);
      // assert
      expect(result, tSearchResult);
    });

    test('should throw ServerException when response code is other than 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.searchTvSeries(tQuery)))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.searchTvSeries(tQuery);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });

  group('get tv series episode', () {
    final tEpisodeList = EpisodeResponse.fromJson(json.decode(readJson('dummy_data/episode.json'))).episodes;
    final tId = 1;
    final tSeasonNumber = 1;

    test('should return list of episode model when the response code is 200', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesSeason(tId, tSeasonNumber))))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/episode.json'), 200));
      // act
      final result = await dataSource.getTvEpisode(tId, tSeasonNumber);
      // assert
      expect(result, equals(tEpisodeList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      // arrange
      when(mockIOClient.get(Uri.parse(ApiUrl.tvSeriesSeason(tId, tSeasonNumber)))).thenAnswer((_) async => http.Response('Not Found', 404));
      // act
      final call = dataSource.getTvEpisode(tId, tSeasonNumber);
      // assert
      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
