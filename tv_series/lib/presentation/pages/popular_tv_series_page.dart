import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_card_list.dart';

class PopularTvSeriesPage extends StatelessWidget {
  static const routeName = '/popular-tv-series';

  const PopularTvSeriesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Tv Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularTvBloc, PopularTvState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case PopularTvLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PopularTvFailure:
                final _msg = (state as PopularTvFailure).failure;
                return Center(
                  key: const Key('error_message'),
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
