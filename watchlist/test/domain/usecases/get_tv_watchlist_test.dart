import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:watchlist/domain/usecases/get_watchlist_tv.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchListTv usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetWatchListTv(mockTvSeriesRepository);
  });

  final tTvSeries = <TvSeries>[];

  test('should get list of tv series watchlist from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getWatchlistTvSeries()).thenAnswer((_) async => Right(tTvSeries));
    //act
    final result = await usecase.execute();
    //assert
    expect(result, Right(tTvSeries));
  });
}
