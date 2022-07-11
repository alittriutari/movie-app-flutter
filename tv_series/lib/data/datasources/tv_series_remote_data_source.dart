import 'dart:convert';
import 'dart:io';

import 'package:core/core.dart';
import 'package:http/io_client.dart';
import 'package:tv_series/data/models/tv_series_detail_model.dart';
import 'package:tv_series/data/models/tv_series_model.dart';
import 'package:tv_series/data/models/tv_series_response.dart';

import '../models/episode_model.dart';
import '../models/episode_response.dart';

abstract class TvSeriesRemoteDataSource {
  Future<List<TvSeriesModel>> getOnAirTvSeries();
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id);
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id);
  Future<List<TvSeriesModel>> getPopularTvSeries();
  Future<List<TvSeriesModel>> getTopRatedTvSeries();
  Future<List<TvSeriesModel>> searchTvSeries(String query);
  Future<List<EpisodeModel>> getTvEpisode(int id, int seasonNumber);
}

class TvSeriesRemoteDataSourceImpl implements TvSeriesRemoteDataSource {
  final IOClient ioClient;

  TvSeriesRemoteDataSourceImpl({required this.ioClient});

  @override
  Future<List<TvSeriesModel>> getOnAirTvSeries() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesOnAir));

    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TvSeriesDetailResponse> getTvSeriesDetail(int id) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesDetail(id)));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTvSeriesRecommendation(int id) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesRecommendation(id)));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getPopularTvSeries() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesPopular));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> getTopRatedTvSeries() async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesTopRated));
    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(jsonDecode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TvSeriesModel>> searchTvSeries(String query) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.searchTvSeries(query)));

    if (response.statusCode == HttpStatus.ok) {
      return TvSeriesResponse.fromJson(json.decode(response.body)).tvSeriesList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<EpisodeModel>> getTvEpisode(int id, int seasonNumber) async {
    final response = await ioClient.get(Uri.parse(ApiUrl.tvSeriesSeason(id, seasonNumber)));

    if (response.statusCode == HttpStatus.ok) {
      return EpisodeResponse.fromJson(jsonDecode(response.body)).episodes;
    } else {
      throw ServerException();
    }
  }
}
