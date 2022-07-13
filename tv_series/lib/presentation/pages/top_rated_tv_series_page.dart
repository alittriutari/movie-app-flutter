import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_card_list.dart';

class TopRatedTvSeriesPage extends StatelessWidget {
  static const routeName = '/top-rated-tv-series';

  const TopRatedTvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TopRatedTvLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TopRatedTvFailure:
                final _msg = (state as TopRatedTvFailure).failure;
                return Center(
                  key: const Key('error_message'),
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
