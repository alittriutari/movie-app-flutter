import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:tv_series/domain/usecases/get_tv_episode.dart';
import 'package:tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:tv_series/domain/usecases/get_tv_series_recommendation.dart';
import 'package:watchlist/watchlist.dart';

//TODO 3 daftarkan class yang ingin di mock pada sebuah fungsi main
// taruh semua class mock dalam 1 berkas

@GenerateMocks([
  SaveWatchlist,
  RemoveWatchlist,
  NetworkInfo,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
  GetPopularTvSeries,
  GetOnAirTvSeries,
  GetTopRatedTv,
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
  SaveTvWatchlist,
  RemoveTvWatchlist,
  GetWatchListStatus,
  GetTvWatchlistStatus,
  GetWatchListTv,
  GetTvEpisode,
  DataConnectionChecker,
  IOClient
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock