import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationTvBloc recommendationTvBloc;
  late MockGetTvSeriesRecommendation mockGetTvSeriesRecommendation;

  setUp(() {
    mockGetTvSeriesRecommendation = MockGetTvSeriesRecommendation();
    recommendationTvBloc = RecommendationTvBloc(getTvSeriesRecommendation: mockGetTvSeriesRecommendation);
  });

  const tId = 1;

  test(
    'initial state should be RecommendationTvInitial',
    () async {
      expect(recommendationTvBloc.state, RecommendationTvInitial());
    },
  );

  blocTest<RecommendationTvBloc, RecommendationTvState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetTvSeriesRecommendation.execute(tId)).thenAnswer((_) async => Right(testTvSeriesList));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc..add(const GetRecommendationTvEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [RecommendationTvLoading(), RecommendationTvLoaded(data: testTvSeriesList)],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendation.execute(tId));
      });

  blocTest<RecommendationTvBloc, RecommendationTvState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetTvSeriesRecommendation.execute(tId)).thenAnswer((_) async => const Left(ServerFailure('')));
        return recommendationTvBloc;
      },
      act: (bloc) => bloc..add(const GetRecommendationTvEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [RecommendationTvLoading(), const RecommendationTvFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetTvSeriesRecommendation.execute(tId));
      });
}
