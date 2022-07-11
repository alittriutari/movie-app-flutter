import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_card_list.dart';

import '../../tv_series.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-tv-series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TopRatedTvLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TopRatedTvFailure:
                final _msg = (state as TopRatedTvFailure).failure;
                return Center(
                  key: Key('error_message'),
                  child: Text(_msg.toString()),
                );
              case TopRatedTvLoaded:
                final _data = (state as TopRatedTvLoaded).data;
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
