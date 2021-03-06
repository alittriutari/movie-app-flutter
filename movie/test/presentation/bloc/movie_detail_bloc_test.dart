import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    movieDetailBloc = MovieDetailBloc(getMovieDetail: mockGetMovieDetail);
  });

  const tId = 1;

  test(
    'initial state should be MovieDetailInitial',
    () async {
      expect(movieDetailBloc.state, MovieDetailInitial());
    },
  );

  blocTest<MovieDetailBloc, MovieDetailState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc..add(const GetMovieDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), const MovieDetailLoaded(data: testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => const Left(ServerFailure('')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc..add(const GetMovieDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), const MovieDetailFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}
