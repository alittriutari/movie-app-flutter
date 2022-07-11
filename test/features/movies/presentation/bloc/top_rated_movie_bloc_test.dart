import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie_app/common/failure.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TopRatedMovieBloc topRatedMovieBloc;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    topRatedMovieBloc = TopRatedMovieBloc(getTopRatedMovies: mockGetTopRatedMovies);
  });

  test(
    'initial state should be PopularMovieInitial',
    () async {
      expect(topRatedMovieBloc.state, TopRatedMovieInitial());
    },
  );

  blocTest<TopRatedMovieBloc, TopRatedMovieState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc..add(GetTopRatedMovieListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [TopRatedMovieLoading(), TopRatedMovieLoaded(data: testMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });

  blocTest<TopRatedMovieBloc, TopRatedMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetTopRatedMovies.execute()).thenAnswer((_) async => Left(ServerFailure('')));
        return topRatedMovieBloc;
      },
      act: (bloc) => bloc..add(GetTopRatedMovieListEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [TopRatedMovieLoading(), TopRatedMovieFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      });
}
