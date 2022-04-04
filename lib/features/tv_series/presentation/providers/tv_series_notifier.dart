import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesListNotifier extends ChangeNotifier {
  var _onAirTvSeries = <TvSeries>[];

  List<TvSeries> get onAirTvSeries => _onAirTvSeries;

  RequestState _onAirState = RequestState.Empty;
  RequestState get onAirState => _onAirState;

  String _message = '';
  String get message => _message;

  TvSeriesListNotifier({required this.getOnAirTvSeries});
  final GetOnAirTvSeries getOnAirTvSeries;

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
}
