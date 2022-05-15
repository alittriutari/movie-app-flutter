import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:movie_app/common/failure.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/presentation/providers/on_air_tv_series_notifier.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockGetOnAirTvSeries mockGetOnAirTvSeries;
  late OnAirTvSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnAirTvSeries = MockGetOnAirTvSeries();
    notifier = OnAirTvSeriesNotifier(mockGetOnAirTvSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tTvSeries = TvSeries(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 5.0,
      posterPath: 'posterPath',
      voteAverage: 1.0,
      voteCount: 1);

  final tTvSeriesList = <TvSeries>[tTvSeries];

  test('should change state to loading when usecase is called', () async {
    //arrange
    when(mockGetOnAirTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
    //act
    notifier.fetchOnAiringTvSeries();
    //assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change on airing tv series data when data is gotten successfully', () async {
    // arrange
    when(mockGetOnAirTvSeries.execute()).thenAnswer((_) async => Right(tTvSeriesList));
    // act
    await notifier.fetchOnAiringTvSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tTvSeriesList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetOnAirTvSeries.execute()).thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchOnAiringTvSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
