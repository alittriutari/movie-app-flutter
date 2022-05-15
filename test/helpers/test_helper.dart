import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:movie_app/common/network_info.dart';
import 'package:movie_app/features/movies/data/datasources/db/movie_database_helper.dart';
import 'package:movie_app/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:movie_app/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_app/features/search/domain/usecases/search_movies.dart';
import 'package:movie_app/features/tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie_app/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_recommendation.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:movie_app/features/tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:movie_app/features/watchlist/domain/usecases/remove_watchlist.dart';
import 'package:movie_app/features/watchlist/domain/usecases/save_watchlist.dart';

//TODO 3 daftarkan class yang ingin di mock pada sebuah fungsi main
// taruh semua class mock dalam 1 berkas

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  SaveWatchlist,
  RemoveWatchlist,
  MovieRepository,
  MovieRemoteDataSource,
  MovieLocalDataSource,
  MovieDatabaseHelper,
  MovieDetailNotifier,
  PopularMoviesNotifier,
  TopRatedMoviesNotifier,
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchlistMovies,
  SearchMovies,
  NetworkInfo,
  TvSeriesRepository,
  TvSeriesRemoteDataSource,
  TvLocalDataSource,
  TvDatabaseHelper,
  GetPopularTvSeries,
  GetOnAirTvSeries,
  GetTvSeriesDetail,
  GetTvSeriesRecommendation,
  SaveTvWatchlist,
  RemoveTvWatchlist,
  GetWatchListStatus,
  GetTvWatchlistStatus,
  GetWatchListTv,
  TvSeriesDetailNotifier,
  TvEpisodeNotifier
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock