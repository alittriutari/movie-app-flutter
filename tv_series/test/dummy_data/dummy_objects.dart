import 'package:movie/movie.dart';
import 'package:tv_series/data/models/tv_series_table.dart';
import 'package:tv_series/domain/entities/episode.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';

final testTvSeries = TvSeries(
    backdropPath: 'backdropPath',
    firstAirDate: 'firstAirDate',
    genreIds: const [14, 28],
    id: 1,
    name: 'name',
    originCountry: const ['US'],
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    overview: 'overview',
    popularity: 2.2,
    posterPath: 'posterPath',
    voteAverage: 2.0,
    voteCount: 1);

final testTvSeriesList = <TvSeries>[testTvSeries];

const testTvDetail = TvSeriesDetail(
    posterPath: 'posterPath',
    backdropPath: 'backdropPath',
    episodeRunTime: [51],
    firstAirDate: '2022-02-25',
    genres: [Genre(id: 1, name: 'Action')],
    id: 1,
    name: 'name',
    numberOfEpisodes: 1,
    numberOfSeasons: 1,
    overview: 'overview',
    voteAverage: 1,
    voteCount: 1);

final testWatchlistTvSeries = TvSeries.watchlist(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

const testTvSeriesTable = TvSeriesTable(
  id: 1,
  name: 'name',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testTvMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

const testEpisode = Episode(airDate: 'airDate', episodeNumber: 1, id: 1, name: 'name', overview: 'overview', seasonNumber: 1, stillPath: 'stillPath', voteAverage: 2.0, voteCount: 1);
final testEpisodeList = <Episode>[testEpisode];
