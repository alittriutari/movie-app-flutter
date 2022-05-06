import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:movie_app/common/network_info.dart';
import 'package:movie_app/features/movies/data/datasources/db/movie_database_helper.dart';
import 'package:movie_app/features/movies/data/datasources/movie_local_data_source.dart';
import 'package:movie_app/features/movies/data/datasources/movie_remote_data_source.dart';
import 'package:movie_app/features/movies/data/repositories/movie_repository_impl.dart';
import 'package:movie_app/features/movies/domain/repositories/movie_repository.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_detail.dart';
import 'package:movie_app/features/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:movie_app/features/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movie_app/features/movies/domain/usecases/get_popular_movies.dart';
import 'package:movie_app/features/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:movie_app/features/search/domain/usecases/search_movies.dart';
import 'package:movie_app/features/search/domain/usecases/search_tv_series.dart';
import 'package:movie_app/features/search/presentation/provider/movie_search_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_app/features/tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_episode.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:movie_app/features/tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:movie_app/features/watchlist/domain/usecases/remove_watchlist.dart';
import 'package:movie_app/features/watchlist/domain/usecases/save_watchlist.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie_app/features/search/presentation/provider/tv_series_search_notifier.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie_app/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:movie_app/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_recommendation.dart';
import 'package:movie_app/features/tv_series/presentation/providers/on_air_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/popular_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_tv_notifier.dart';

final locator = GetIt.instance;

void init() {
  // provider
  locator.registerFactory(
    () => MovieListNotifier(
      getNowPlayingMovies: locator(),
      getPopularMovies: locator(),
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailNotifier(
      getMovieDetail: locator(),
      getMovieRecommendations: locator(),
      getWatchListStatus: locator(),
      saveWatchlist: locator(),
      removeWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => SearchMovieNotifier(
      searchMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => PopularMoviesNotifier(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TopRatedMoviesNotifier(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
    () => TvSeriesListNotifier(getOnAirTvSeries: locator(), getPopularTvSeries: locator()),
  );

  locator.registerFactory(
    () => OnAirTvSeriesNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => PopularTvSeriesNotifier(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvSeriesDetailNotifier(
      getTvSeriesDetail: locator(),
      getTvSeriesRecommendation: locator(),
      getTvWatchlistStatus: locator(),
      saveTvWatchlist: locator(),
      removeTvWatchlist: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvSeriesNotifier(searchTvSeries: locator()),
  );

  locator.registerFactory(
    () => WatchlistTvNotifier(getWatchListTv: locator()),
  );

  locator.registerFactory(
    () => TvEpisodeNotifier(getTvEpisode: locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));
  locator.registerLazySingleton(() => GetOnAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTvSeriesRecommendation(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => SearchTvSeries(locator()));
  locator.registerLazySingleton(() => GetTvWatchlistStatus(locator()));
  locator.registerLazySingleton(() => SaveTvWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchListTv(locator()));
  locator.registerLazySingleton(() => GetTvEpisode(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(remoteDataSource: locator(), localDataSource: locator(), networkInfo: locator()),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
    () => TvSeriesRepositoryImpl(remoteDataSource: locator(), localDataSource: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(() => TvSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(() => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
}
