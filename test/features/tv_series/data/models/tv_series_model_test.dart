import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final tTvSeriesModel = TvSeriesModel(
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

  test('should be a subclass of Movie entity', () async {
    final result = tTvSeriesModel.toEntity();
    expect(result, tTvSeries);
  });
}
