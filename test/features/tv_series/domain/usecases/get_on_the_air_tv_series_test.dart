import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetOnAirTvSeries usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetOnAirTvSeries(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of on airing tv series from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getOnAirTvSeries()).thenAnswer((_) async => Right(tTvSeries));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvSeries));
  });
}
