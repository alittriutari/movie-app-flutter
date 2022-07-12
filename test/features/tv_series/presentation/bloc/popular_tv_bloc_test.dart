import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularTvBloc popularTvBloc;
  late MockGetPopularTvSeries mockGetPopularTvSeries;

  setUp(() {
    mockGetPopularTvSeries = MockGetPopularTvSeries();
    popularTvBloc = PopularTvBloc(getPopularTvSeries: mockGetPopularTvSeries);
  });

  test(
    'initial state should be PopularTvInitial',
    () async {
      expect(popularTvBloc.state, PopularTvInitial());
    },
  );

  blocTest<PopularTvBloc, PopularTvState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Right(testTvSeriesList));
        return popularTvBloc;
      },
      act: (bloc) => bloc..add(GetPopularTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [PopularTvLoading(), PopularTvLoaded(data: testTvSeriesList)],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });

  blocTest<PopularTvBloc, PopularTvState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetPopularTvSeries.execute()).thenAnswer((_) async => Left(ServerFailure('')));
        return popularTvBloc;
      },
      act: (bloc) => bloc..add(GetPopularTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [PopularTvLoading(), PopularTvFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetPopularTvSeries.execute());
      });
}
