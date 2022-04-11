import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/tv_series/presentation/providers/on_air_tv_series_notifier.dart';
import 'package:ditonton/features/tv_series/presentation/widget/tv_series_card_list.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class OnAirTvSeriesPage extends StatefulWidget {
  static const ROUTE_NAME = '/on-air-tv-series';

  @override
  State<OnAirTvSeriesPage> createState() => _OnAirTvSeriesPageState();
}

class _OnAirTvSeriesPageState extends State<OnAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<OnAirTvSeriesNotifier>(context, listen: false).fetchOnAiringTvSeries());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Airing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Consumer<OnAirTvSeriesNotifier>(
          builder: (context, data, child) {
            if (data.state == RequestState.Loading) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (data.state == RequestState.Loaded) {
              return ListView.builder(
                itemCount: data.tvSeries.length,
                itemBuilder: (context, index) {
                  final tvSeries = data.tvSeries[index];
                  return TvSeriesCard(tvSeries);
                },
              );
            }
            return Center(
              key: Key('error_message'),
              child: Text(data.message),
            );
          },
        ),
      ),
    );
  }
}
