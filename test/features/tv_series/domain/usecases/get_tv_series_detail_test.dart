import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvSeriesDetail usecase;
  late MockTvSeriesRepository mockTvSeriesRepository;

  setUp(() {
    mockTvSeriesRepository = MockTvSeriesRepository();
    usecase = GetTvSeriesDetail(mockTvSeriesRepository);
  });

  final tId = 1;

  test('should get tv series detail from the repository', () async {
    //arrange
    when(mockTvSeriesRepository.getTvSeriesDetail(tId)).thenAnswer((_) async => Right(testTvDetail));
    //act
    final result = await usecase.execute(tId);
    //assert
    expect(result, Right(testTvDetail));
  });
}
