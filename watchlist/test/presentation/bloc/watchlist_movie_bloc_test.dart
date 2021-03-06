import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';

import '../../../../movie/test/dummy_data/dummy_objects.dart';
import '../../../../movie/test/helpers/test_helper.mocks.dart';

void main() {
  late MockGetWatchlistMovies mockGetWatchlistMovies;
  late MockGetWatchListStatus mockGetWatchListStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;
  late WatchlistMovieBloc watchlistMovieBloc;

  setUp(() {
    mockGetWatchlistMovies = MockGetWatchlistMovies();
    mockGetWatchListStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    watchlistMovieBloc = WatchlistMovieBloc(
        getWatchListStatus: mockGetWatchListStatus,
        getWatchlistMovies: mockGetWatchlistMovies,
        saveWatchlist: mockSaveWatchlist,
        removeWatchlist: mockRemoveWatchlist);
  });

  const tId = 1;

  test(
    'initial state should WatchlistMovieInitial',
    () async {
      expect(watchlistMovieBloc.state, WatchlistMovieInitial());
    },
  );

  group('get watchlist movie', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Loaded] when  data is gotten successfully.',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => Right(testMovieList));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(GetWatchlistMovieEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), WatchlistMovieLoaded(testMovieList)],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockGetWatchlistMovies.execute()).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(GetWatchlistMovieEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockGetWatchlistMovies.execute());
        });
  });

  group('save watchlist movie', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Action] when  data is gotten successfully.',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async => const Right('success'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(const AddWatchlistMovieEvent(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieAction('success')],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockSaveWatchlist.execute(testMovieDetail)).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(const AddWatchlistMovieEvent(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockSaveWatchlist.execute(testMovieDetail));
        });
  });

  group('remove watchlist movie', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Action] when  data is gotten successfully.',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((_) async => const Right('success'));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(const RemoveWatchlistMovieEvent(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieAction('success')],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });

    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockRemoveWatchlist.execute(testMovieDetail)).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(const RemoveWatchlistMovieEvent(testMovieDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockRemoveWatchlist.execute(testMovieDetail));
        });
  });

  group('load watchlist movie status', () {
    blocTest<WatchlistMovieBloc, WatchlistMovieState>('emits [Loading, Changed] when  data is successfull.',
        build: () {
          when(mockGetWatchListStatus.execute(tId)).thenAnswer((_) async => true);
          return watchlistMovieBloc;
        },
        act: (bloc) => bloc..add(const LoadWatchlistMovieEvent(tId)),
        expect: () => [WatchlistMovieLoading(), const WatchlistMovieChanged(true)],
        verify: (bloc) {
          verify(mockGetWatchListStatus.execute(tId));
        });
  });
}
