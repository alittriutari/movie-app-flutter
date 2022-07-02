import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:http/io_client.dart';
import 'package:movie_app/common/exception.dart';
import 'package:movie_app/features/movies/data/models/movie_detail_model.dart';
import 'package:movie_app/features/movies/data/models/movie_model.dart';
import 'package:movie_app/features/movies/data/models/movie_response.dart';

import '../../../../common/utils.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  static const API_KEY = 'api_key=9c93c65e03d4ec78611e0ddd9fb55db3';
  static const BASE_URL = 'https://api.themoviedb.org/3';

  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$BASE_URL/movie/now_playing?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$BASE_URL/movie/$id?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$BASE_URL/movie/$id/recommendations?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$BASE_URL/movie/popular?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);

    final response = await ioClient.get(Uri.parse('$BASE_URL/movie/top_rated?$API_KEY'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    HttpClient client = HttpClient(context: await globalContext);
    client.badCertificateCallback = (X509Certificate cert, String host, int port) => false;
    IOClient ioClient = IOClient(client);
    final response = await ioClient.get(Uri.parse('$BASE_URL/search/movie?$API_KEY&query=$query'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
