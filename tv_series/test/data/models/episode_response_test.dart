import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/episode_model.dart';
import 'package:tv_series/data/models/episode_response.dart';

import '../../json_reader.dart';

void main() {
  const tEpisodeModel = EpisodeModel(
      airDate: '2022-02-25',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      stillPath: '/path.jpg',
      voteAverage: 1.0,
      voteCount: 1);

  const tEpisodeResponseModel = EpisodeResponse(
      id: '1',
      airDate: '2022-02-25',
      episodes: <EpisodeModel>[tEpisodeModel],
      name: 'Season 1',
      overview: 'overview',
      episodeId: 1,
      posterPath: '/path.jpg',
      seasonNumber: 1);

  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap = jsonDecode(readJson('dummy_data/episode.json'));
      // act
      final result = EpisodeResponse.fromJson(jsonMap);
      // assert
      expect(result, tEpisodeResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tEpisodeResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "_id": "1",
        "air_date": "2022-02-25",
        "episodes": [
          {
            "air_date": "2022-02-25",
            "episode_number": 1,
            "id": 1,
            "name": "name",
            "overview": "overview",
            "season_number": 1,
            "still_path": "/path.jpg",
            "vote_average": 1.0,
            "vote_count": 1
          }
        ],
        "name": "Season 1",
        "overview": "overview",
        "id": 1,
        "poster_path": "/path.jpg",
        "season_number": 1
      };
      expect(result, expectedJsonMap);
    });
  });
}
