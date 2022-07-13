import 'package:core/core.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:mockito/annotations.dart';

//TODO 3 daftarkan class yang ingin di mock pada sebuah fungsi main
// taruh semua class mock dalam 1 berkas

@GenerateMocks([NetworkInfo, DataConnectionChecker, IOClient], customMocks: [MockSpec<http.Client>(as: #MockHttpClient)])
void main() {}

//TODO 4 jalankan perintah 'flutter pub run build_runner build' untuk generate class mock