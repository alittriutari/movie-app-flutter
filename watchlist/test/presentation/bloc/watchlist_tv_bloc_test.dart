import 'package:bloc_test/bloc_test.dart';
import 'package:core/core.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

import '../../../../tv_series/test/dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetWatchListTv mockGetWatchListTv;
  late MockGetTvWatchlistStatus mockGetTvWatchlistStatus;
  late MockSaveTvWatchlist mockSaveTvWatchlist;
  late MockRemoveTvWatchlist mockRemoveTvWatchlist;
  late WatchlistTvBloc watchlistTvBloc;

  setUp(() {
    mockGetWatchListTv = MockGetWatchListTv();
    mockGetTvWatchlistStatus = MockGetTvWatchlistStatus();
    mockSaveTvWatchlist = MockSaveTvWatchlist();
    mockRemoveTvWatchlist = MockRemoveTvWatchlist();
    watchlistTvBloc = WatchlistTvBloc(
        getTvWatchlistStatus: mockGetTvWatchlistStatus,
        getWatchlistTv: mockGetWatchListTv,
        saveTvWatchlist: mockSaveTvWatchlist,
        removeTvWatchlist: mockRemoveTvWatchlist);
  });

  const tId = 1;

  test(
    'initial state should WatchlistTvInitial',
    () async {
      expect(watchlistTvBloc.state, WatchlistTvInitial());
    },
  );

  group('get watchlist tv', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Loaded] when  data is gotten successfully.',
        build: () {
          when(mockGetWatchListTv.execute()).thenAnswer((_) async => Right(testTvSeriesList));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(GetWatchlistTvEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), WatchlistTvLoaded(testTvSeriesList)],
        verify: (bloc) {
          verify(mockGetWatchListTv.execute());
        });

    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockGetWatchListTv.execute()).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(GetWatchlistTvEvent()),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), const WatchlistTvFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockGetWatchListTv.execute());
        });
  });

  group('save watchlist tv', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Action] when  data is gotten successfully.',
        build: () {
          when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Right('success'));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(const AddWatchlistTvEvent(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), const WatchlistTvAction('success')],
        verify: (bloc) {
          verify(mockSaveTvWatchlist.execute(testTvDetail));
        });

    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockSaveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(const AddWatchlistTvEvent(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), const WatchlistTvFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockSaveTvWatchlist.execute(testTvDetail));
        });
  });

  group('remove watchlist tv', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Action] when  data is gotten successfully.',
        build: () {
          when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Right('success'));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(const RemoveWatchlistTvEvent(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), const WatchlistTvAction('success')],
        verify: (bloc) {
          verify(mockRemoveTvWatchlist.execute(testTvDetail));
        });

    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Failure] when  data is unsuccessful.',
        build: () {
          when(mockRemoveTvWatchlist.execute(testTvDetail)).thenAnswer((_) async => const Left(ServerFailure('')));
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(const RemoveWatchlistTvEvent(testTvDetail)),
        wait: const Duration(milliseconds: 100),
        expect: () => [WatchlistTvLoading(), const WatchlistTvFailure(failure: ServerFailure(''))],
        verify: (bloc) {
          verify(mockRemoveTvWatchlist.execute(testTvDetail));
        });
  });

  group('load watchlist tv status', () {
    blocTest<WatchlistTvBloc, WatchlistTvState>('emits [Loading, Changed] when  data is successfull.',
        build: () {
          when(mockGetTvWatchlistStatus.execute(tId)).thenAnswer((_) async => true);
          return watchlistTvBloc;
        },
        act: (bloc) => bloc..add(const LoadWatchlistTvEvent(tId)),
        expect: () => [WatchlistTvLoading(), const WatchlistTvChanged(true)],
        verify: (bloc) {
          verify(mockGetTvWatchlistStatus.execute(tId));
        });
  });
}
