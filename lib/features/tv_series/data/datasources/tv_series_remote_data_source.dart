import 'dart:convert';
import 'dart:io';

import 'package:ditonton/common/api_url.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_detail_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_model.dart';
import 'package:ditonton/features/tv_series/data/models/tv_series_response.dart';
import 'package:http/http.dart' as http;

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnAirTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id);
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
}
