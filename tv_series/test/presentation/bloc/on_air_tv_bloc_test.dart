import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/on_air_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late OnAirTvBloc onAirTvBloc;
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;

  setUp(() {
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    onAirTvBloc = OnAirTvBloc(getOnAirTvSeries: mockGetOnAirTvSeries);
  });

  test(
    'initial state should be OnAirTvInitial',
    () async {
      expect(onAirTvBloc.state, OnAirTvInitial());
    },
  );

  blocTest<OnAirTvBloc, OnAirTvState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetOnAirTvSeries.execute()).thenAnswer((_) async => Right(testTvSeriesList));
        return onAirTvBloc;
      },
      act: (bloc) => bloc..add(GetOnAirTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [OnAirTvLoading(), OnAirTvLoaded(data: testTvSeriesList)],
      verify: (bloc) {
        verify(mockGetOnAirTvSeries.execute());
      });

  blocTest<OnAirTvBloc, OnAirTvState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetOnAirTvSeries.execute()).thenAnswer((_) async => const Left(ServerFailure('')));
        return onAirTvBloc;
      },
      act: (bloc) => bloc..add(GetOnAirTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [OnAirTvLoading(), const OnAirTvFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetOnAirTvSeries.execute());
      });
}
