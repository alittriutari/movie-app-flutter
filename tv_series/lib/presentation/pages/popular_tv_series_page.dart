import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../tv_series.dart';
import '../widget/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatelessWidget {
  static const ROUTE_NAME = '/popular-tv-series';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case PopularTvLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case PopularTvFailure:
                final _msg = (state as PopularTvFailure).failure;
                return Center(
                  key: Key('error_message'),
                  child: Text(_msg.toString()),
                );
              case PopularTvLoaded:
                final _data = (state as PopularTvLoaded).data;
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
