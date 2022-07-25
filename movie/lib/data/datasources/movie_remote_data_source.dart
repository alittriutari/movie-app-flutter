import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:movie/movie.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlayingMovies();
  Future<List<MovieModel>> getPopularMovies();
  Future<List<MovieModel>> getTopRatedMovies();
  Future<MovieDetailResponse> getMovieDetail(int id);
  Future<List<MovieModel>> getMovieRecommendations(int id);
  Future<List<MovieModel>> searchMovies(String query);
}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final IOClient ioClient;

  MovieRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<MovieModel>> getNowPlayingMovies() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.movieNowPlaying));
    // final response = await ioClient.get(Uri.parse('google.com'));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getMovieDetail(int id) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.movieDetail(id)));

    if (response.statusCode == HttpStatus.ok) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getMovieRecommendations(int id) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.movieRecommencation(id)));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopularMovies() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.moviePopular));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getTopRatedMovies() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.movieTopRated));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> searchMovies(String query) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.searchMovies(query)));

    if (response.statusCode == HttpStatus.ok) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }
}
