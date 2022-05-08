import 'package:flutter/cupertino.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_episode.dart';

class TvEpisodeNotifier extends ChangeNotifier {
  final GetTvEpisode getTvEpisode;

  TvEpisodeNotifier({required this.getTvEpisode});

  late List<Episode> _episode;
  List<Episode> get episode => _episode;

  RequestState _episodeState = RequestState.Empty;
  RequestState get episodeState => _episodeState;

  String _message = '';
  String get message => _message;

  Future<void> fetchEpisode(int id, int seasonNumber) async {
    _episodeState = RequestState.Loading;
    notifyListeners();
    final episodeResult = await getTvEpisode.execute(id, seasonNumber);

    episodeResult.fold((failure) {
      _episodeState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (eps) {
      _episodeState = RequestState.Loaded;
      _episode = eps;
      notifyListeners();
    });
  }
}
