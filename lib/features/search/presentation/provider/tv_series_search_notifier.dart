import 'package:flutter/material.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/search/domain/usecases/search_tv_series.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

class SearchTvSeriesNotifier extends ChangeNotifier {
  final SearchTvSeries searchTvSeries;

  SearchTvSeriesNotifier({required this.searchTvSeries});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<TvSeries> _searchResult = [];
  List<TvSeries> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvSeriesSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchTvSeries.execute(query);
    result.fold(
      (failure) {
        _message = failure.message;
        _state = RequestState.Error;
        notifyListeners();
      },
      (data) {
        _searchResult = data;
        _state = RequestState.Loaded;
        notifyListeners();
      },
    );
  }
}
