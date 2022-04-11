import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:flutter/cupertino.dart';

class OnAirTvSeriesNotifier extends ChangeNotifier {
  final GetOnAirTvSeries getOnAirTvSeries;

  OnAirTvSeriesNotifier(this.getOnAirTvSeries);

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _tvSeries = [];
  List<TvSeries> get tvSeries => _tvSeries;

  String _message = '';
  String get message => _message;

  Future<void> fetchOnAiringTvSeries() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getOnAirTvSeries.execute();

    result.fold((failure) {
      _message = failure.message;
      _state = RequestState.Error;
      notifyListeners();
    }, (tvSeriesData) {
      _tvSeries = tvSeriesData;
      _state = RequestState.Loaded;
      notifyListeners();
    });
  }
}
