import 'package:ditonton/common/network_info.dart';
import 'package:ditonton/data/datasources/db/database_helper.dart';
import 'package:ditonton/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

//TODO 3 daftarkan class yang ingin di mock pada sebuah fungsi main
// taruh semua class mock dalam 1 berkas

@GenerateMocks([MovieRepository, MovieRemoteDataSource, MovieLocalDataSource, DatabaseHelper, NetworkInfo],
    customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock