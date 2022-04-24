import 'package:movie_app/common/exception.dart';
import 'package:movie_app/features/tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_table.dart';

abstract class TvLocalDataSource {
  Future<String> insertWatchlist(TvSeriesTable tvSeries);
  Future<String> removeWatchlist(TvSeriesTable tvSeries);
  Future<TvSeriesTable?> getTvSerieById(int id);
  Future<List<TvSeriesTable>> getWatchlistTvSeries();
}

class TvLocalDataSourceImpl implements TvLocalDataSource {
  final TvDatabaseHelper databaseHelper;

  TvLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<TvSeriesTable?> getTvSerieById(int id) async {
    final result = await databaseHelper.getTvSeriesById(id);
    if (result != null) {
      return TvSeriesTable.fromMap(result);
    } else {
      return null;
    }
  }

  @override
  Future<List<TvSeriesTable>> getWatchlistTvSeries() async {
    final result = await databaseHelper.getWatchlistTvSeries();
    return result.map((data) => TvSeriesTable.fromMap(data)).toList();
  }

  @override
  Future<String> insertWatchlist(TvSeriesTable tvSeries) async {
    try {
      databaseHelper.insertWatchlist(tvSeries);
      return 'Added to Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }

  @override
  Future<String> removeWatchlist(TvSeriesTable tvSeries) async {
    try {
      await databaseHelper.removeWatchlist(tvSeries);
      return 'Removed from Watchlist';
    } catch (e) {
      throw DatabaseException(e.toString());
    }
  }
}
