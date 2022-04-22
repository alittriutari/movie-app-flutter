import 'dart:convert';

import 'package:movie_app/features/tv_series/data/models/tv_series_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../../json_reader.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
      backdropPath: '/path.jpg',
      firstAirDate: 'first air date',
      genreIds: [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: ['US'],
      originalLanguage: 'en',
      originalName: 'original name',
      overview: 'overview',
      popularity: 5.0,
      posterPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1);
  final tTvSeriesResponseModel = TvSeriesResponse(tvSeriesList: <TvSeriesModel>[tTvSeriesModel]);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(readJson('dummy_data/tv_series_airing.json'));
      // act
      final result = TvSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tTvSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tTvSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "first_air_date": "first air date",
            "genre_ids": [1, 2, 3],
            "id": 1,
            "name": "name",
            "origin_country": ["US"],
            "original_language": "en",
            "original_name": "original name",
            "overview": "overview",
            "popularity": 5.0,
            "poster_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
