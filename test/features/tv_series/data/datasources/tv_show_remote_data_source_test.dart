import 'dart:convert';

import 'package:ditonton/common/api_url.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;

import '../../../../helpers/test_helper.mocks.dart';
import '../../../../json_reader.dart';

void main() {
  late TvSeriesRemoteDataSourceImpl dataSource;
  late MockHttpClient mockHttpClient;

  setUp(() {
    mockHttpClient = MockHttpClient();
    dataSource = TvSeriesRemoteDataSourceImpl(client: mockHttpClient);
  });

  group('get on the air tv series', () {
    final tOnAirTvSeriesList = TvSeriesResponse.fromJson(jsonDecode(readJson('dummy_data/on_air_now_tv_series.json'))).tvSeriesList;

    test('should return list of Tv Series Model when the response code is 200', () async {
      when(mockHttpClient.get(Uri.parse(ApiUrl.tvSeriesonAir)))
          .thenAnswer((_) async => http.Response(readJson('dummy_data/on_air_now_tv_series.json'), 200));

      final result = await dataSource.getonAirTvSeries();

      expect(result, equals(tOnAirTvSeriesList));
    });

    test('should throw Server Exception when the response code is 404 or other', () async {
      when(mockHttpClient.get(Uri.parse(ApiUrl.tvSeriesonAir))).thenAnswer((_) async => http.Response('Not found', 404));

      final call = dataSource.getonAirTvSeries();

      expect(() => call, throwsA(isA<ServerException>()));
    });
  });
}
