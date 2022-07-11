import 'package:flutter/foundation.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/search/domain/usecases/search_movies.dart';
import 'package:movies/domain/entities/movie.dart';

class SearchMovieNotifier extends ChangeNotifier {
  final SearchMovies searchMovies;

  SearchMovieNotifier({required this.searchMovies});

  RequestState _state = RequestState.Empty;
  RequestState get state => _state;

  List<Movie> _searchResult = [];
  List<Movie> get searchResult => _searchResult;

  String _message = '';
  String get message => _message;

  Future<void> fetchMovieSearch(String query) async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await searchMovies.execute(query);
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
