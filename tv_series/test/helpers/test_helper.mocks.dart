// Mocks generated by Mockito 5.2.0 from annotations
// in tv_series/test/helpers/test_helper.dart.
// Do not manually edit this file.

import 'dart:async' as _i10;
import 'dart:convert' as _i25;
import 'dart:typed_data' as _i26;

import 'package:core/core.dart' as _i11;
import 'package:dartz/dartz.dart' as _i3;
import 'package:data_connection_checker/data_connection_checker.dart' as _i5;
import 'package:http/io_client.dart' as _i6;
import 'package:http/src/base_request.dart' as _i24;
import 'package:http/src/client.dart' as _i27;
import 'package:http/src/response.dart' as _i7;
import 'package:http/src/streamed_response.dart' as _i8;
import 'package:mockito/mockito.dart' as _i1;
import 'package:movie/domain/repositories/movie_repository.dart' as _i2;
import 'package:movie/movie.dart' as _i12;
import 'package:sqflite/sqflite.dart' as _i18;
import 'package:tv_series/data/datasources/db/tv_database_helper.dart' as _i17;
import 'package:tv_series/domain/entities/episode.dart' as _i16;
import 'package:tv_series/domain/entities/tv_series.dart' as _i14;
import 'package:tv_series/domain/entities/tv_series_detail.dart' as _i15;
import 'package:tv_series/tv_series.dart' as _i4;
import 'package:watchlist/domain/usecases/get_tv_watchlist_status.dart' as _i22;
import 'package:watchlist/domain/usecases/get_watchlist_status.dart' as _i21;
import 'package:watchlist/domain/usecases/get_watchlist_tv.dart' as _i23;
import 'package:watchlist/domain/usecases/remove_tv_watchlist.dart' as _i20;
import 'package:watchlist/domain/usecases/remove_watchlist.dart' as _i13;
import 'package:watchlist/domain/usecases/save_tv_watchlist.dart' as _i19;
import 'package:watchlist/domain/usecases/save_watchlist.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeMovieRepository_0 extends _i1.Fake implements _i2.MovieRepository {}

class _FakeEither_1<L, R> extends _i1.Fake implements _i3.Either<L, R> {}

class _FakeTvSeriesDetailResponse_2 extends _i1.Fake
    implements _i4.TvSeriesDetailResponse {}

class _FakeTvSeriesRepository_3 extends _i1.Fake
    implements _i4.TvSeriesRepository {}

class _FakeDuration_4 extends _i1.Fake implements Duration {}

class _FakeAddressCheckResult_5 extends _i1.Fake
    implements _i5.AddressCheckResult {}

class _FakeIOStreamedResponse_6 extends _i1.Fake
    implements _i6.IOStreamedResponse {}

class _FakeResponse_7 extends _i1.Fake implements _i7.Response {}

class _FakeStreamedResponse_8 extends _i1.Fake implements _i8.StreamedResponse {
}

/// A class which mocks [SaveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveWatchlist extends _i1.Mock implements _i9.SaveWatchlist {
  MockSaveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> execute(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
}

/// A class which mocks [RemoveWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveWatchlist extends _i1.Mock implements _i13.RemoveWatchlist {
  MockRemoveWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> execute(
          _i12.MovieDetail? movie) =>
      (super.noSuchMethod(Invocation.method(#execute, [movie]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
}

/// A class which mocks [NetworkInfo].
///
/// See the documentation for Mockito's code generation for more information.
class MockNetworkInfo extends _i1.Mock implements _i11.NetworkInfo {
  MockNetworkInfo() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<bool> get isConnected =>
      (super.noSuchMethod(Invocation.getter(#isConnected),
          returnValue: Future<bool>.value(false)) as _i10.Future<bool>);
}

/// A class which mocks [TvSeriesRepository].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRepository extends _i1.Mock
    implements _i4.TvSeriesRepository {
  MockTvSeriesRepository() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>
      getOnAirTvSeries() => (super.noSuchMethod(
              Invocation.method(#getOnAirTvSeries, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>
      getPopularTvSeries() => (super.noSuchMethod(
              Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>
      getTopRatedTvSeries() => (super.noSuchMethod(
              Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>> getTvSeriesDetail(
          int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>>.value(
                      _FakeEither_1<_i11.Failure, _i15.TvSeriesDetail>()))
          as _i10.Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>
      getTvSeriesRecommendation(int? id) => (super.noSuchMethod(
              Invocation.method(#getTvSeriesRecommendation, [id]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> searchTvSeries(
          String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i16.Episode>>> getTvEpisode(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(Invocation.method(#getTvEpisode, [id, seasonNumber]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i16.Episode>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i16.Episode>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i16.Episode>>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> saveWatchlist(
          _i15.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#saveWatchlist, [tvSeries]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> removeWatchlist(
          _i15.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
  @override
  _i10.Future<bool> isAddedToWatchlist(int? id) =>
      (super.noSuchMethod(Invocation.method(#isAddedToWatchlist, [id]),
          returnValue: Future<bool>.value(false)) as _i10.Future<bool>);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>
      getWatchlistTvSeries() => (super.noSuchMethod(
              Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [TvSeriesRemoteDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvSeriesRemoteDataSource extends _i1.Mock
    implements _i4.TvSeriesRemoteDataSource {
  MockTvSeriesRemoteDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<List<_i4.TvSeriesModel>> getOnAirTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getOnAirTvSeries, []),
              returnValue:
                  Future<List<_i4.TvSeriesModel>>.value(<_i4.TvSeriesModel>[]))
          as _i10.Future<List<_i4.TvSeriesModel>>);
  @override
  _i10.Future<_i4.TvSeriesDetailResponse> getTvSeriesDetail(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesDetail, [id]),
              returnValue: Future<_i4.TvSeriesDetailResponse>.value(
                  _FakeTvSeriesDetailResponse_2()))
          as _i10.Future<_i4.TvSeriesDetailResponse>);
  @override
  _i10.Future<List<_i4.TvSeriesModel>> getTvSeriesRecommendation(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesRecommendation, [id]),
              returnValue:
                  Future<List<_i4.TvSeriesModel>>.value(<_i4.TvSeriesModel>[]))
          as _i10.Future<List<_i4.TvSeriesModel>>);
  @override
  _i10.Future<List<_i4.TvSeriesModel>> getPopularTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getPopularTvSeries, []),
              returnValue:
                  Future<List<_i4.TvSeriesModel>>.value(<_i4.TvSeriesModel>[]))
          as _i10.Future<List<_i4.TvSeriesModel>>);
  @override
  _i10.Future<List<_i4.TvSeriesModel>> getTopRatedTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getTopRatedTvSeries, []),
              returnValue:
                  Future<List<_i4.TvSeriesModel>>.value(<_i4.TvSeriesModel>[]))
          as _i10.Future<List<_i4.TvSeriesModel>>);
  @override
  _i10.Future<List<_i4.TvSeriesModel>> searchTvSeries(String? query) =>
      (super.noSuchMethod(Invocation.method(#searchTvSeries, [query]),
              returnValue:
                  Future<List<_i4.TvSeriesModel>>.value(<_i4.TvSeriesModel>[]))
          as _i10.Future<List<_i4.TvSeriesModel>>);
  @override
  _i10.Future<List<_i4.EpisodeModel>> getTvEpisode(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(Invocation.method(#getTvEpisode, [id, seasonNumber]),
              returnValue:
                  Future<List<_i4.EpisodeModel>>.value(<_i4.EpisodeModel>[]))
          as _i10.Future<List<_i4.EpisodeModel>>);
}

/// A class which mocks [TvLocalDataSource].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvLocalDataSource extends _i1.Mock implements _i4.TvLocalDataSource {
  MockTvLocalDataSource() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<String> insertWatchlist(_i4.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i10.Future<String>);
  @override
  _i10.Future<String> removeWatchlist(_i4.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
          returnValue: Future<String>.value('')) as _i10.Future<String>);
  @override
  _i10.Future<_i4.TvSeriesTable?> getTvSerieById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSerieById, [id]),
              returnValue: Future<_i4.TvSeriesTable?>.value())
          as _i10.Future<_i4.TvSeriesTable?>);
  @override
  _i10.Future<List<_i4.TvSeriesTable>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
              returnValue:
                  Future<List<_i4.TvSeriesTable>>.value(<_i4.TvSeriesTable>[]))
          as _i10.Future<List<_i4.TvSeriesTable>>);
}

/// A class which mocks [TvDatabaseHelper].
///
/// See the documentation for Mockito's code generation for more information.
class MockTvDatabaseHelper extends _i1.Mock implements _i17.TvDatabaseHelper {
  MockTvDatabaseHelper() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i18.Database?> get database =>
      (super.noSuchMethod(Invocation.getter(#database),
              returnValue: Future<_i18.Database?>.value())
          as _i10.Future<_i18.Database?>);
  @override
  _i10.Future<int> insertWatchlist(_i4.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#insertWatchlist, [tvSeries]),
          returnValue: Future<int>.value(0)) as _i10.Future<int>);
  @override
  _i10.Future<int> removeWatchlist(_i4.TvSeriesTable? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#removeWatchlist, [tvSeries]),
          returnValue: Future<int>.value(0)) as _i10.Future<int>);
  @override
  _i10.Future<Map<String, dynamic>?> getTvSeriesById(int? id) =>
      (super.noSuchMethod(Invocation.method(#getTvSeriesById, [id]),
              returnValue: Future<Map<String, dynamic>?>.value())
          as _i10.Future<Map<String, dynamic>?>);
  @override
  _i10.Future<List<Map<String, dynamic>>> getWatchlistTvSeries() =>
      (super.noSuchMethod(Invocation.method(#getWatchlistTvSeries, []),
              returnValue: Future<List<Map<String, dynamic>>>.value(
                  <Map<String, dynamic>>[]))
          as _i10.Future<List<Map<String, dynamic>>>);
}

/// A class which mocks [GetPopularTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetPopularTvSeries extends _i1.Mock
    implements _i4.GetPopularTvSeries {
  MockGetPopularTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [GetOnAirTvSeries].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetOnAirTvSeries extends _i1.Mock implements _i4.GetOnAirTvSeries {
  MockGetOnAirTvSeries() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [GetTopRatedTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTopRatedTv extends _i1.Mock implements _i4.GetTopRatedTv {
  MockGetTopRatedTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [GetTvSeriesDetail].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvSeriesDetail extends _i1.Mock implements _i4.GetTvSeriesDetail {
  MockGetTvSeriesDetail() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>>.value(
                      _FakeEither_1<_i11.Failure, _i15.TvSeriesDetail>()))
          as _i10.Future<_i3.Either<_i11.Failure, _i15.TvSeriesDetail>>);
}

/// A class which mocks [GetTvSeriesRecommendation].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvSeriesRecommendation extends _i1.Mock
    implements _i4.GetTvSeriesRecommendation {
  MockGetTvSeriesRecommendation() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [SaveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockSaveTvWatchlist extends _i1.Mock implements _i19.SaveTvWatchlist {
  MockSaveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> execute(
          _i15.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeries]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
}

/// A class which mocks [RemoveTvWatchlist].
///
/// See the documentation for Mockito's code generation for more information.
class MockRemoveTvWatchlist extends _i1.Mock implements _i20.RemoveTvWatchlist {
  MockRemoveTvWatchlist() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, String>> execute(
          _i15.TvSeriesDetail? tvSeries) =>
      (super.noSuchMethod(Invocation.method(#execute, [tvSeries]),
              returnValue: Future<_i3.Either<_i11.Failure, String>>.value(
                  _FakeEither_1<_i11.Failure, String>()))
          as _i10.Future<_i3.Either<_i11.Failure, String>>);
}

/// A class which mocks [GetWatchListStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListStatus extends _i1.Mock
    implements _i21.GetWatchListStatus {
  MockGetWatchListStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MovieRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeMovieRepository_0()) as _i2.MovieRepository);
  @override
  _i10.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i10.Future<bool>);
}

/// A class which mocks [GetTvWatchlistStatus].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvWatchlistStatus extends _i1.Mock
    implements _i22.GetTvWatchlistStatus {
  MockGetTvWatchlistStatus() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<bool> execute(int? id) =>
      (super.noSuchMethod(Invocation.method(#execute, [id]),
          returnValue: Future<bool>.value(false)) as _i10.Future<bool>);
}

/// A class which mocks [GetWatchListTv].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetWatchListTv extends _i1.Mock implements _i23.GetWatchListTv {
  MockGetWatchListTv() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>> execute() =>
      (super.noSuchMethod(Invocation.method(#execute, []),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i14.TvSeries>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i14.TvSeries>>>);
}

/// A class which mocks [GetTvEpisode].
///
/// See the documentation for Mockito's code generation for more information.
class MockGetTvEpisode extends _i1.Mock implements _i4.GetTvEpisode {
  MockGetTvEpisode() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i4.TvSeriesRepository get repository =>
      (super.noSuchMethod(Invocation.getter(#repository),
          returnValue: _FakeTvSeriesRepository_3()) as _i4.TvSeriesRepository);
  @override
  _i10.Future<_i3.Either<_i11.Failure, List<_i16.Episode>>> execute(
          int? id, int? seasonNumber) =>
      (super.noSuchMethod(Invocation.method(#execute, [id, seasonNumber]),
              returnValue:
                  Future<_i3.Either<_i11.Failure, List<_i16.Episode>>>.value(
                      _FakeEither_1<_i11.Failure, List<_i16.Episode>>()))
          as _i10.Future<_i3.Either<_i11.Failure, List<_i16.Episode>>>);
}

/// A class which mocks [DataConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockDataConnectionChecker extends _i1.Mock
    implements _i5.DataConnectionChecker {
  MockDataConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i5.AddressCheckOptions> get addresses =>
      (super.noSuchMethod(Invocation.getter(#addresses),
              returnValue: <_i5.AddressCheckOptions>[])
          as List<_i5.AddressCheckOptions>);
  @override
  set addresses(List<_i5.AddressCheckOptions>? _addresses) =>
      super.noSuchMethod(Invocation.setter(#addresses, _addresses),
          returnValueForMissingStub: null);
  @override
  Duration get checkInterval =>
      (super.noSuchMethod(Invocation.getter(#checkInterval),
          returnValue: _FakeDuration_4()) as Duration);
  @override
  set checkInterval(Duration? _checkInterval) =>
      super.noSuchMethod(Invocation.setter(#checkInterval, _checkInterval),
          returnValueForMissingStub: null);
  @override
  List<_i5.AddressCheckResult> get lastTryResults => (super.noSuchMethod(
      Invocation.getter(#lastTryResults),
      returnValue: <_i5.AddressCheckResult>[]) as List<_i5.AddressCheckResult>);
  @override
  _i10.Future<bool> get hasConnection =>
      (super.noSuchMethod(Invocation.getter(#hasConnection),
          returnValue: Future<bool>.value(false)) as _i10.Future<bool>);
  @override
  _i10.Future<_i5.DataConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(Invocation.getter(#connectionStatus),
              returnValue: Future<_i5.DataConnectionStatus>.value(
                  _i5.DataConnectionStatus.disconnected))
          as _i10.Future<_i5.DataConnectionStatus>);
  @override
  _i10.Stream<_i5.DataConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(Invocation.getter(#onStatusChange),
              returnValue: Stream<_i5.DataConnectionStatus>.empty())
          as _i10.Stream<_i5.DataConnectionStatus>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  bool get isActivelyChecking =>
      (super.noSuchMethod(Invocation.getter(#isActivelyChecking),
          returnValue: false) as bool);
  @override
  _i10.Future<_i5.AddressCheckResult> isHostReachable(
          _i5.AddressCheckOptions? options) =>
      (super.noSuchMethod(Invocation.method(#isHostReachable, [options]),
              returnValue: Future<_i5.AddressCheckResult>.value(
                  _FakeAddressCheckResult_5()))
          as _i10.Future<_i5.AddressCheckResult>);
}

/// A class which mocks [IOClient].
///
/// See the documentation for Mockito's code generation for more information.
class MockIOClient extends _i1.Mock implements _i6.IOClient {
  MockIOClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i6.IOStreamedResponse> send(_i24.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue: Future<_i6.IOStreamedResponse>.value(
                  _FakeIOStreamedResponse_6()))
          as _i10.Future<_i6.IOStreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
  @override
  _i10.Future<_i7.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i10.Future<String>);
  @override
  _i10.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i10.Future<_i26.Uint8List>);
}

/// A class which mocks [Client].
///
/// See the documentation for Mockito's code generation for more information.
class MockHttpClient extends _i1.Mock implements _i27.Client {
  MockHttpClient() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i10.Future<_i7.Response> head(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#head, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> get(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#get, [url], {#headers: headers}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> post(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#post, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> put(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#put, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> patch(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#patch, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<_i7.Response> delete(Uri? url,
          {Map<String, String>? headers,
          Object? body,
          _i25.Encoding? encoding}) =>
      (super.noSuchMethod(
              Invocation.method(#delete, [url],
                  {#headers: headers, #body: body, #encoding: encoding}),
              returnValue: Future<_i7.Response>.value(_FakeResponse_7()))
          as _i10.Future<_i7.Response>);
  @override
  _i10.Future<String> read(Uri? url, {Map<String, String>? headers}) =>
      (super.noSuchMethod(Invocation.method(#read, [url], {#headers: headers}),
          returnValue: Future<String>.value('')) as _i10.Future<String>);
  @override
  _i10.Future<_i26.Uint8List> readBytes(Uri? url,
          {Map<String, String>? headers}) =>
      (super.noSuchMethod(
              Invocation.method(#readBytes, [url], {#headers: headers}),
              returnValue: Future<_i26.Uint8List>.value(_i26.Uint8List(0)))
          as _i10.Future<_i26.Uint8List>);
  @override
  _i10.Future<_i8.StreamedResponse> send(_i24.BaseRequest? request) =>
      (super.noSuchMethod(Invocation.method(#send, [request]),
              returnValue:
                  Future<_i8.StreamedResponse>.value(_FakeStreamedResponse_8()))
          as _i10.Future<_i8.StreamedResponse>);
  @override
  void close() => super.noSuchMethod(Invocation.method(#close, []),
      returnValueForMissingStub: null);
}