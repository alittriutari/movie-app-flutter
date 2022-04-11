import 'package:ditonton/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';
  final int id;

  TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.microtask(() => Provider.of<TvSeriesDetailNotifier>(context, listen: false));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
