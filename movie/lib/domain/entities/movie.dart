import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
class Movie extends Equatable {
  Movie({
    required this.adult,
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalTitle,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.video,
    required this.voteAverage,
    required this.voteCount,
  });

  Movie.watchlist({
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.title,
  });

  bool? adult;
  String? backdropPath;
  List<int>? genreIds;
  final int id;
  String? originalTitle;
  final String? overview;
  double? popularity;
  String? posterPath;
  String? releaseDate;
  final String? title;
  bool? video;
  double? voteAverage;
  int? voteCount;

  @override
  List<Object?> get props => [
        adult,
        backdropPath,
        genreIds,
        id,
        originalTitle,
        overview,
        popularity,
        posterPath,
        releaseDate,
        title,
        video,
        voteAverage,
        voteCount,
      ];
}
