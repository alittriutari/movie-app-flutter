import 'package:equatable/equatable.dart';
import 'package:movie/domain/entities/genre.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.posterPath,
    required this.backdropPath,
    required this.episodeRunTime,
    required this.firstAirDate,
    required this.genres,
    required this.id,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.overview,
    required this.voteAverage,
    required this.voteCount,
  });

  final String backdropPath;
  final List<int> episodeRunTime;
  final String firstAirDate;
  final List<Genre> genres;
  final int id;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final String overview;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        backdropPath,
        episodeRunTime,
        firstAirDate,
        genres,
        id,
        name,
        numberOfEpisodes,
        overview,
        posterPath,
        voteAverage,
        voteCount,
      ];
}
