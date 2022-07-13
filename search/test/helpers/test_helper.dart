import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';
import 'package:movie/domain/repositories/movie_repository.dart';
import 'package:search/domain/usecases/search_movies.dart';
import 'package:search/domain/usecases/search_tv_series.dart';
import 'package:tv_series/domain/repositories/tv_series_repository.dart';

//TODO 3 daftarkan class yang ingin di mock pada sebuah fungsi main
// taruh semua class mock dalam 1 berkas

@GenerateMocks([MovieRepository, SearchTvSeries, SearchMovies, TvSeriesRepository, DataConnectionChecker, IOClient], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock