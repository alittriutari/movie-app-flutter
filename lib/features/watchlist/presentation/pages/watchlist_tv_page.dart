import 'package:flutter/material.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/features/tv_series/presentation/widget/tv_series_grid_widget.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_tv_notifier.dart';
import 'package:provider/provider.dart';

class WatchlistTvPage extends StatefulWidget {
  const WatchlistTvPage({Key? key}) : super(key: key);

  @override
  State<WatchlistTvPage> createState() => _WatchlistTvPageState();
}

class _WatchlistTvPageState extends State<WatchlistTvPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        Provider.of<WatchlistTvNotifier>(context, listen: false)
            .fetchWatchlistTv());
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  void didPopNext() {
    Provider.of<WatchlistTvNotifier>(context, listen: false).fetchWatchlistTv();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: EdgeInsets.all(8.0),
          child: Consumer<WatchlistTvNotifier>(
            builder: (context, data, child) {
              if (data.watchlistState == RequestState.Loading) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              } else if (data.watchlistState == RequestState.Loaded) {
                final tvSeries = data.watchlistTv;
                return TVSeriesListGrid(tvSeries);
              } else {
                return Center(
                  key: Key('error_message'),
                  child: Text(data.message),
                );
              }
            },
          )),
    );
  }
}
