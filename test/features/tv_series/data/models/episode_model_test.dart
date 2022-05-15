import 'package:flutter_test/flutter_test.dart';
import 'package:movie_app/features/tv_series/data/models/episode_model.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';

void main() {
  final tEpisodeModel = EpisodeModel(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1);

  final tEpisode = Episode(
      airDate: 'airDate',
      episodeNumber: 1,
      id: 1,
      name: 'name',
      overview: 'overview',
      seasonNumber: 1,
      stillPath: 'stillPath',
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of episode entity', () {
    final result = tEpisodeModel.toEntity();
    expect(result, tEpisode);
  });
}