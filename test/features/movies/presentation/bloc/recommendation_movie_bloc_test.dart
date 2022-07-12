import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movies/presentation/bloc/recommendation_movie_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late RecommendationMovieBloc recommendationMovieBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    recommendationMovieBloc = RecommendationMovieBloc(getMovieRecommendations: mockGetMovieRecommendations);
  });

  const tId = 1;

  test(
    'initial state should be RecommendationMovieInitial',
    () async {
      expect(recommendationMovieBloc.state, RecommendationMovieInitial());
    },
  );

  blocTest<RecommendationMovieBloc, RecommendationMovieState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Right(testMovieList));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc..add(GetRecommendationMovieEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [RecommendationMovieLoading(), RecommendationMovieLoaded(data: testMovieList)],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });

  blocTest<RecommendationMovieBloc, RecommendationMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetMovieRecommendations.execute(tId)).thenAnswer((_) async => Left(ServerFailure('')));
        return recommendationMovieBloc;
      },
      act: (bloc) => bloc..add(GetRecommendationMovieEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [RecommendationMovieLoading(), RecommendationMovieFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetMovieRecommendations.execute(tId));
      });
}
