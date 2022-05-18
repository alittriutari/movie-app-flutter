import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_top_rated_tv.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTopRatedTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTopRatedTv(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of top rated tv series from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTopRatedTvSeries()).thenAnswer((_) async => Right(tTvSeries));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvSeries));
  });
}
