import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_grid_widget.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistTvBloc>().add(GetWatchlistTvEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: BlocBuilder<WatchlistTvBloc, WatchlistTvState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case WatchlistTvLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case WatchlistTvFailure:
              final _failure = (state as WatchlistTvFailure).failure;
              return Center(child: Text(_failure.message));
            case WatchlistTvLoaded:
              final tv = (state as WatchlistTvLoaded).tv;
              return TVSeriesListGrid(tv);
            case WatchlistTvInitial:
              return Center(
                child: Text(
                  'Your watchlist is empty',
                  style: kSubtitle,
                ),
              );
          }
          return const SizedBox.shrink();
        },
      ),
    ));
  }
}
