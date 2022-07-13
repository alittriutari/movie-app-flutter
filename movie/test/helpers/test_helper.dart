import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/data/datasources/db/movie_database_helper.dart';
import 'package:movie/data/datasources/movie_local_data_source.dart';
import 'package:movie/data/datasources/movie_remote_data_source.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:movie/domain/usecases/get_movie_detail.dart';
import 'package:movie/domain/usecases/get_movie_recommendations.dart';
import 'package:movie/domain/usecases/get_now_playing_movies.dart';
import 'package:movie/domain/usecases/get_popular_movies.dart';
import 'package:movie/domain/usecases/get_top_rated_movies.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:watchlist/watchlist.dart';

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
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
  GetWatchlistMovies,
  SearchMovies,
  GetWatchListStatus,
  DataConnectionChecker,
  NetworkInfo,
  IOClient
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock