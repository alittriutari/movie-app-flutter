import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendation.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesRecommendation usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesRecommendation(mockTvSeriesRepository);
  });

  const tId = 1;
  final tTvSeries = <TvSeries>[];

  test('should get list of tv series recommendation from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesRecommendation(tId)).thenAnswer((_) async => Right(tTvSeries));
    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(tTvSeries));
  });
}
