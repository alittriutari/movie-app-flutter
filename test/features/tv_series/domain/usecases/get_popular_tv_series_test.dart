import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetPopularTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetPopularTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of popular tv series from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getPopularTvSeries()).thenAnswer((_) async => Right(tTvSeries));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvSeries));
  });
}
