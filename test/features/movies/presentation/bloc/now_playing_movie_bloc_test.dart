import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/movies/presentation/bloc/now_playing_movie_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late NowPlayingMovieBloc nowPlayingMovieBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    nowPlayingMovieBloc = NowPlayingMovieBloc(mockGetNowPlayingMovies);
  });

  test(
    'initial state should be NowPlayingMovieInitial',
    () async {
      expect(nowPlayingMovieBloc.state, NowPlayingMovieInitial());
    },
  );

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Right(testMovieList));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc..add(GetNowPlayingMovieEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [NowPlayingMovieLoading(), NowPlayingMovieLoaded(data: testMovieList)],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });

  blocTest<NowPlayingMovieBloc, NowPlayingMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetNowPlayingMovies.execute()).thenAnswer((_) async => Left(ServerFailure('')));
        return nowPlayingMovieBloc;
      },
      act: (bloc) => bloc..add(GetNowPlayingMovieEvent()),
      wait: const Duration(milliseconds: 100),
      expect: () => [NowPlayingMovieLoading(), NowPlayingMovieFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      });
}
