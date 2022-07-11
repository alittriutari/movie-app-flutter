import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/episode_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late EpisodeBloc episodeBloc;
  late MockGetTvEpisode mockGetTvEpisode;

  setUp(() {
    mockGetTvEpisode = MockGetTvEpisode();
    episodeBloc = EpisodeBloc(getTvEpisode: mockGetTvEpisode);
  });

  const tId = 1;
  const tSeason = 1;

  test(
    'initial state should be EpisodeInitial',
    () async {
      expect(episodeBloc.state, EpisodeInitial());
    },
  );

  blocTest<EpisodeBloc, EpisodeState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetTvEpisode.execute(tId, tSeason)).thenAnswer((_) async => Right(testEpisodeList));
        return episodeBloc;
      },
      act: (bloc) => bloc..add(GetEpisodeEvent(id: tId, seasonNumber: tSeason)),
      wait: const Duration(milliseconds: 100),
      expect: () => [EpisodeLoading(), EpisodeLoaded(data: testEpisodeList)],
      verify: (bloc) {
        verify(mockGetTvEpisode.execute(tId, tSeason));
      });

  blocTest<EpisodeBloc, EpisodeState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetTvEpisode.execute(tId, tSeason)).thenAnswer((_) async => Left(ServerFailure('')));
        return episodeBloc;
      },
      act: (bloc) => bloc..add(GetEpisodeEvent(id: tId, seasonNumber: tSeason)),
      wait: const Duration(milliseconds: 100),
      expect: () => [EpisodeLoading(), EpisodeFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetTvEpisode.execute(tId, tSeason));
      });
}
