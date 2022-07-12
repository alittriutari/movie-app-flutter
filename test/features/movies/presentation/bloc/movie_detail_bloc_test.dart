import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
<<<<<<< HEAD
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie_app/common/failure.dart';
=======
import 'package:movies/presentation/bloc/movie_detail_bloc.dart';
>>>>>>> 723ed042fd115a45c29e3650534c0ec73bbdb97a

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

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
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => Right(testMovieDetail));
        return movieDetailBloc;
      },
      act: (bloc) => bloc..add(GetMovieDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), MovieDetailLoaded(data: testMovieDetail)],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });

  blocTest<MovieDetailBloc, MovieDetailState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetMovieDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc..add(GetMovieDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [MovieDetailLoading(), MovieDetailFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(tId));
      });
}
