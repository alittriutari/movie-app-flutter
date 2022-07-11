import 'package:core/core.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:watchlist/watchlist.dart';

class WatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-page';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(8),
          child: Scaffold(
            appBar: TabBar(indicatorColor: kMikadoYellow, unselectedLabelColor: Colors.white.withOpacity(0.5), indicatorWeight: 3, tabs: const [
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Movies'),
                ),
              ),
              Tab(
                child: Align(
                  alignment: Alignment.center,
                  child: Text('Tv Series'),
                ),
              ),
            ]),
            body: TabBarView(
              physics: const BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              children: [WatchlistMoviesPage(), const WatchlistTvPage()],
            ),
          ),
        ),
      ),
    );
  }
}
