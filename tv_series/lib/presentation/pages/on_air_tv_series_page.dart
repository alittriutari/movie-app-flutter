import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_card_list.dart';
import 'package:tv_series/tv_series.dart';

class OnAirTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/on-air-tv-series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('On Airing Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case OnAirTvLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case OnAirTvFailure:
                final _msg = (state as OnAirTvFailure).failure;
                return Center(
                  key: Key('error_message'),
                  child: Text(_msg.toString()),
                );
              case OnAirTvLoaded:
                final _data = (state as OnAirTvLoaded).data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final tv = _data[index];
                    return TvSeriesCard(tv);
                  },
                  itemCount: _data.length,
                );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
