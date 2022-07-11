import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/data/repositories/movie_repository_impl.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:movie_app/ssl_helper.dart';
import 'package:tv_series/data/datasources/db/tv_database_helper.dart';
import 'package:tv_series/domain/usecases/get_tv_watchlist_status.dart';
import 'package:tv_series/domain/usecases/remove_tv_watchlist.dart';
import 'package:tv_series/domain/usecases/save_tv_watchlist.dart';
import 'package:tv_series/presentation/bloc/watchlist_tv_bloc.dart';
import 'package:tv_series/tv_series.dart';
import 'package:watchlist/watchlist.dart';

final locator = GetIt.instance;

Future init() async {
  IOClient ioClient = await SSLHelper.ioClient;

  //bloc
  locator.registerFactory(() => NowPlayingMovieBloc(getNowPlayingMovies: locator()));
  locator.registerFactory(() => PopularMovieBloc(getPopularMovies: locator()));
  locator.registerFactory(() => TopRatedMovieBloc(getTopRatedMovies: locator()));
  locator.registerFactory(() => RecommendationMovieBloc(getMovieRecommendations: locator()));
  locator.registerFactory(() => MovieDetailBloc(getMovieDetail: locator()));
  locator.registerFactory(() => WatchlistMovieBloc(getWatchListStatus: locator(), getWatchlistMovies: locator(), removeWatchlist: locator(), saveWatchlist: locator()));

  locator.registerFactory(() => OnAirTvBloc(getOnAirTvSeries: locator()));
  locator.registerFactory(() => PopularTvBloc(getPopularTvSeries: locator()));
  locator.registerFactory(() => TopRatedTvBloc(getTopRatedTv: locator()));
  locator.registerFactory(() => TvDetailBloc(getTvSeriesDetail: locator()));
  locator.registerFactory(() => RecommendationTvBloc(getTvSeriesRecommendation: locator()));

  locator.registerFactory(() => WatchlistTvBloc(getTvWatchlistStatus: locator(), getWatchlistTv: locator(), removeTvWatchlist: locator(), saveTvWatchlist: locator()));
  locator.registerFactory(() => EpisodeBloc(getTvEpisode: locator()));

  // provider

  locator.registerFactory(
    () => SearchMovieNotifier(
      searchMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => WatchlistMovieNotifier(
      getWatchlistMovies: locator(),
    ),
  );

  locator.registerFactory(
    () => SearchTvSeriesNotifier(searchTvSeries: locator()),
  );

  locator.registerFactory(
    () => WatchlistTvNotifier(getWatchListTv: locator()),
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
