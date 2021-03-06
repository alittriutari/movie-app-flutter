import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedTvBloc topRatedTvBloc;
  late MockGetTopRatedTv mockGetTopRatedTv;

  setUp(() {
    mockGetTopRatedTv = MockGetTopRatedTv();
    topRatedTvBloc = TopRatedTvBloc(getTopRatedTv: mockGetTopRatedTv);
  });

  test(
    'initial state should be TopRatedTvInitial',
    () async {
      expect(topRatedTvBloc.state, TopRatedTvInitial());
    },
  );

  blocTest<TopRatedTvBloc, TopRatedTvState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => Right(testTvSeriesList));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc..add(GetTopRatedTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [TopRatedTvLoading(), TopRatedTvLoaded(data: testTvSeriesList)],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });

  blocTest<TopRatedTvBloc, TopRatedTvState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetTopRatedTv.execute()).thenAnswer((_) async => const Left(ServerFailure('')));
        return topRatedTvBloc;
      },
      act: (bloc) => bloc..add(GetTopRatedTvListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [TopRatedTvLoading(), const TopRatedTvFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetTopRatedTv.execute());
      });
}
