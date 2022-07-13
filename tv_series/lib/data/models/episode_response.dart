import 'package:equatable/equatable.dart';
import 'package:tv_series/data/models/episode_model.dart';

class EpisodeResponse extends Equatable {
  const EpisodeResponse({
    required this.id,
    required this.airDate,
    required this.episodes,
    required this.name,
    required this.overview,
    required this.episodeId,
    required this.posterPath,
    required this.seasonNumber,
  });

  final String id;
  final String airDate;
  final List<EpisodeModel> episodes;
  final String name;
  final String overview;
  final int episodeId;
  final String? posterPath;
  final int seasonNumber;

  factory EpisodeResponse.fromJson(Map<String, dynamic> json) =>
      EpisodeResponse(
        id: json["_id"],
        airDate: json["air_date"],
        episodes: List<EpisodeModel>.from(
            json["episodes"].map((x) => EpisodeModel.fromJson(x))),
        name: json["name"],
        overview: json["overview"],
        episodeId: json["id"],
        posterPath: json["poster_path"],
        seasonNumber: json["season_number"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "air_date": airDate,
        "episodes": List<dynamic>.from(episodes.map((x) => x.toJson())),
        "name": name,
        "overview": overview,
        "id": episodeId,
        "poster_path": posterPath,
        "season_number": seasonNumber,
      };

  @override
  List<Object?> get props => [
        id,
        airDate,
        episodes,
        name,
        overview,
        episodeId,
        posterPath,
        seasonNumber,
      ];
}
