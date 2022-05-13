import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_episode.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvEpisode usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvEpisode(mockTvSeriesRepository);
  });

  final tId = 1;
  final tSeasonNumber = 1;
  final tEpisode = <Episode>[];

  test('should get list of episode of tv series from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTvEpisode(tId, tSeasonNumber)).thenAnswer((_) async => Right(tEpisode));
    //act
    final result = await usecase.execute(tId, tSeasonNumber);
    //assert
    expect(result, Right(tEpisode));
  });
}
