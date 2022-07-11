import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/tv_detail_bloc.dart';

import '../../../../dummy_data/dummy_objects.dart';
import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvSeriesDetail mockGetTvSeriesDetail;

  setUp(() {
    mockGetTvSeriesDetail = MockGetTvSeriesDetail();
    tvDetailBloc = TvDetailBloc(getTvSeriesDetail: mockGetTvSeriesDetail);
  });

  const tId = 1;

  test(
    'initial state should be TvDetailInitial',
    () async {
      expect(tvDetailBloc.state, TvDetailInitial());
    },
  );

  blocTest<TvDetailBloc, TvDetailState>('emits [Loading, Loaded] when  data is gotten successfully.',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc..add(GetTvDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [TvDetailLoading(), TvDetailLoaded(data: testTvDetail)],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      });

  blocTest<TvDetailBloc, TvDetailState>('emits [Loading, Failure] when  data is unsuccessful.',
      build: () {
        when(mockGetTvSeriesDetail.execute(tId)).thenAnswer((_) async => Left(ServerFailure('')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc..add(GetTvDetailEvent(tId)),
      wait: const Duration(milliseconds: 100),
      expect: () => [TvDetailLoading(), TvDetailFailure(failure: ServerFailure(''))],
      verify: (bloc) {
        verify(mockGetTvSeriesDetail.execute(tId));
      });
}
