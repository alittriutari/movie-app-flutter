import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_recommendation.dart';
import 'package:flutter/cupertino.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:movie_app/features/tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/domain/usecases/save_tv_watchlist.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;
  final GetTvSeriesRecommendation getTvSeriesRecommendation;
  final GetTvWatchlistStatus getTvWatchlistStatus;
  final SaveTvWatchlist saveTvWatchlist;
  final RemoveTvWatchlist removeTvWatchlist;

  TvSeriesDetailNotifier(
      {required this.getTvSeriesDetail,
      required this.getTvSeriesRecommendation,
      required this.getTvWatchlistStatus,
      required this.saveTvWatchlist,
      required this.removeTvWatchlist});

  late TvSeriesDetail _tvSerie;
  TvSeriesDetail get tvSeries => _tvSerie;

  late List<TvSeries> _tvSeriesRecommendation = [];
  List<TvSeries> get tvSeriesRecommendation => _tvSeriesRecommendation;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  RequestState _recommendationState = RequestState.Empty;
  RequestState get recommendationState => _recommendationState;

  String _message = '';
  String get message => _message;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> fetchTvSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTvSeriesDetail.execute(id);
    final recommendationResult = await getTvSeriesRecommendation.execute(id);

    detailResult.fold((failure) {
      _tvSeriesState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSerie) {
      _recommendationState = RequestState.Loading;
      _tvSerie = tvSerie;
      notifyListeners();
      recommendationResult.fold((failure) {
        _recommendationState = RequestState.Error;
        _message = failure.message;
      }, (tvSeries) {
        _recommendationState = RequestState.Loaded;
        _tvSeriesRecommendation = tvSeries;
      });
      _tvSeriesState = RequestState.Loaded;

      notifyListeners();
    });
  }

  Future<void> addWatchList(TvSeriesDetail tvSeries) async {
    final result = await saveTvWatchlist.execute(tvSeries);
    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> removeFromWatchlist(TvSeriesDetail tvSeries) async {
    final result = await removeTvWatchlist.execute(tvSeries);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tvSeries.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getTvWatchlistStatus.execute(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
