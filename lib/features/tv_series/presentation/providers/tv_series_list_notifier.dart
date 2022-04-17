import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _onAirTvSeries = <TvSeries>[];
  List<TvSeries> get onAirTvSeries => _onAirTvSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  var _popularTvSeries = <TvSeries>[];
  List<TvSeries> get popularTvSeries => _popularTvSeries;

  RequestState _popularTvSeriesState = RequestState.Empty;
  RequestState get popularTvSeriesState => _popularTvSeriesState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier(
      {required this.getOnAirTvSeries, required this.getPopularTvSeries});

  final GetOnAirTvSeries getOnAirTvSeries;
  final GetPopularTvSeries getPopularTvSeries;

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
}
