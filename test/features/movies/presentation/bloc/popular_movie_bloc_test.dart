import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/presentation/bloc/popular_movie_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late PopularMovieBloc popularMovieBloc;
  late MockGetPopularMovies mockGetPopularMovies;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    popularMovieBloc = PopularMovieBloc(getPopularMovies: mockGetPopularMovies);
  });

  test(
    'initial state should be PopularMovieInitial',
    () async {
      expect(popularMovieBloc.state, PopularMovieInitial());
    },
  );

  blocTest<PopularMovieBloc, PopularMovieState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return popularMovieBloc;
      },
      act: (bloc) => bloc..add(GetPopularMovieEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [PopularMovieLoading(), PopularMovieLoaded(data: testMovieList)],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });

  blocTest<PopularMovieBloc, PopularMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetPopularMovies.execute()).thenAnswer((_) async => Left(ServerFailure('')));
        return popularMovieBloc;
      },
      act: (bloc) => bloc..add(GetPopularMovieEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [PopularMovieLoading(), PopularMovieFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      });
}
