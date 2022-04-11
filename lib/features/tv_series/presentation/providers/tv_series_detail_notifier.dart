import 'package:ditonton/features/tv_series/domain/usecases/get_tv_series_detail.dart';
import 'package:flutter/cupertino.dart';

class TvSeriesDetailNotifier extends ChangeNotifier {
  final GetTvSeriesDetail getTvSeriesDetail;

  TvSeriesDetailNotifier({required this.getTvSeriesDetail});
}
