import 'dart:convert';
import 'dart:io';

import 'package:movie_app/common/api_url.dart';
import 'package:movie_app/common/exception.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_model.dart';
import 'package:movie_app/features/tv_series/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnAirTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id);
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> searchTvSeries(String query);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final http.Client client;

  TvSeriesRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TvSeriesModel>> getOnAirTvSeries() async {
    final response = await client.get(Uri.parse(ApiUrl.tvSeriesOnAir));

    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await client.get(Uri.parse(ApiUrl.tvSeriesDetail(id)));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id) async {
    final response = await client.get(Uri.parse(ApiUrl.tvSeriesRecommendation(id)));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await client.get(Uri.parse(ApiUrl.tvSeriesPopular));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await client.get(Uri.parse(ApiUrl.searchTvSeries(query)));

    if (response.statusCode == 200) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }
}
