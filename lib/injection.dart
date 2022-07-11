import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
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
import 'package:movie_app/features/movies/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_app/features/search/domain/usecases/search_movies.dart';
import 'package:movie_app/features/search/domain/usecases/search_tv_series.dart';
import 'package:movie_app/features/search/presentation/provider/movie_search_notifier.dart';
import 'package:movie_app/features/search/presentation/provider/tv_series_search_notifier.dart';
import 'package:movie_app/features/tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_local_data_source.dart';
import 'package:movie_app/features/tv_series/data/datasources/tv_series_remote_data_source.dart';
import 'package:movie_app/features/tv_series/data/repositories/tv_series_repository_impl.dart';
import 'package:movie_app/features/tv_series/domain/repositories/tv_series_repository.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_top_rated_tv.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_episode.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_series_recommendation.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:movie_app/features/tv_series/domain/usecases/get_watchlist_tv.dart';
import 'package:movie_app/features/tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/episode_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/on_air_tv_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/tv_detail_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:movie_app/features/tv_series/presentation/providers/on_air_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/popular_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/top_rated_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_movies.dart';
import 'package:movie_app/features/watchlist/domain/usecases/get_watchlist_status.dart';
import 'package:movie_app/features/watchlist/domain/usecases/remove_watchlist.dart';
import 'package:movie_app/features/watchlist/domain/usecases/save_watchlist.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_tv_notifier.dart';
import 'package:movie_app/ssl_helper.dart';

final locator = GetIt.instance;

Future init() async {
  IOClient ioClient = await SSLHelper.ioClient;

  //bloc
  locator.registerFactory(() => NowPlayingMovieBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => PopularMovieBloc(getPopularMovies: locator()));
  locator.registerFactory(() => TopRatedMovieBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => RecommendationMovieBloc(getMovieRecommendations: locator()));
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(
      () => WatchlistMovieBloc(getWatchListStatus: locator(), getWatchlistMovies: locator(), removeWatchlist: locator(), saveWatchlist: locator()));

  locator.registerFactory(() => OnAirTvBloc(getOnAirTvSeries: locator()));
  locator.registerFactory(() => PopularTvBloc(getPopularTvSeries: locator()));
  locator.registerFactory(() => TopRatedTvBloc(getTopRatedTv: locator()));
  locator.registerFactory(() => TvDetailBloc(getTvSeriesDetail: locator()));
  locator.registerFactory(() => RecommendationTvBloc(getTvSeriesRecommendation: locator()));

  locator.registerFactory(
      () => WatchlistTvBloc(getTvWatchlistStatus: locator(), getWatchlistTv: locator(), removeTvWatchlist: locator(), saveTvWatchlist: locator()));
  locator.registerFactory(() => EpisodeBloc(getTvEpisode: locator()));

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
    () => TvSeriesListNotifier(getOnAirTvSeries: locator(), getPopularTvSeries: locator(), getTopRatedTv: locator()),
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
    () => TopRatedTvSeriesNotifier(
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
  locator.registerLazySingleton(() => GetTopRatedTv(locator()));
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
    () => TvSeriesRepositoryImpl(remoteDataSource: locator(), localDataSource: locator(), networkInfo: locator()),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(() => MovieRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(() => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(() => TvSeriesRemoteDataSourceImpl(ioClient: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(() => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<MovieDatabaseHelper>(() => MovieDatabaseHelper());
  locator.registerLazySingleton<TvDatabaseHelper>(() => TvDatabaseHelper());

  //network info
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => DataConnectionChecker());
  locator.registerLazySingleton(() => ioClient);
}
