import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetTvEpisode mockGetTvEpisode;
  late TvEpisodeNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvEpisode = MockGetTvEpisode();
    notifier = TvEpisodeNotifier(getTvEpisode: mockGetTvEpisode)
      ..addListener(() {
        listenerCallCount++;
      });
  });

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

  final tEpisodeList = <Episode>[tEpisode];

  final tId = 1;
  final tSeasonNumber = 1;

  test('should change state to loading when usecase is called', () async {
    //arrange
    when(mockGetTvEpisode.execute(tId, tSeasonNumber)).thenAnswer((_) async => Right(tEpisodeList));
    //act
    notifier.fetchEpisode(tId, tSeasonNumber);
    //assert
    expect(notifier.episodeState, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change episode data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvEpisode.execute(tId, tSeasonNumber)).thenAnswer((_) async => Right(tEpisodeList));
    // act
    await notifier.fetchEpisode(tId, tSeasonNumber);
    // assert
    expect(notifier.episodeState, RequestState.Loaded);
    expect(notifier.episode, tEpisodeList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvEpisode.execute(tId, tSeasonNumber)).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchEpisode(tId, tSeasonNumber);
    // assert
    expect(notifier.episodeState, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
