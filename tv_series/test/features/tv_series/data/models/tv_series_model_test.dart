import 'package:flutter_test/flutter_test.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

void main() {
  const tTvSeriesModel = TvSeriesModel(
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
  final tTvSeries = TvSeries(
      backdropPath: 'backdropPath',
      firstAirDate: 'firstAirDate',
      genreIds: const [1, 2, 3],
      id: 1,
      name: 'name',
      originCountry: const ['originCountry'],
      originalLanguage: 'originalLanguage',
      originalName: 'originalName',
      overview: 'overview',
      popularity: 5.0,
      posterPath: 'posterPath',
      voteAverage: 1.0,
      voteCount: 1);

  test('should be a subclass of Tv Series entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
