import 'package:ditonton/features/movies/domain/entities/genre.dart';
import 'package:equatable/equatable.dart';

class TvSeriesDetail extends Equatable {
  TvSeriesDetail({
    required this.originalTitle,
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.runtime,
    required this.title,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String originalTitle;
  final String overview;
  final String posterPath;
  final String releaseDate;
  final int runtime;
  final String title;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genres,
        id,
        overview,
        posterPath,
        releaseDate,
        runtime,
        title,
        voteAverage,
        voteCount,
      ];
}
