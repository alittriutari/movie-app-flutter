import 'package:flutter/cupertino.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_top_rated_tv.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _onAirTvSeries = <TvSeries>[];
  List<TvSeries> get onAirTvSeries => _onAirTvSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  var _topRatedTvSeries = <TvSeries>[];
  List<TvSeries> get topRatedTvSeries => _topRatedTvSeries;

  RequestState _topRatedTvSeriesState = RequestState.Empty;
  RequestState get topRatedTvSeriesState => _topRatedTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({required this.getOnAirTvSeries, required this.getPopularTvSeries, required this.getTopRatedTv});

  final GetOnAirTvSeries getOnAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;
  final GetTopRatedTv getTopRatedTv;

  Future<void> fetchOnAirTvSeries() async {
    _onAirState = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvSeries.execute();
    result.fold((failure) {
      _onAirState = RequestState.Error;
      _message = failure.message;
      notifyListeners();
    }, (tvSeriesData) {
      _onAirState = RequestState.Loaded;
      _onAirTvSeries = tvSeriesData;
      notifyListeners();
    });
  }

  Future<void> fetchPopularTvSeries() async {
    _popularTvSeriesState = RequestState.Loading;
    notifyListeners();
    final result = await getPopularTvSeries.execute();
    result.fold((failure) {
      _message = failure.message;
      _popularTvSeriesState = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _popularTvSeries = tvSeriesData;
      _popularTvSeriesState = RequestState.Loaded;
      notifyListeners();
    });
  }

  Future<void> fetchTopRatedTvSeries() async {
    _topRatedTvSeriesState = RequestState.Loading;
    notifyListeners();
    final result = await getTopRatedTv.execute();
    result.fold((failure) {
      _message = failure.message;
      _topRatedTvSeriesState = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _topRatedTvSeries = tvSeriesData;
      _topRatedTvSeriesState = RequestState.Loaded;
      notifyListeners();
    });
  }
}
