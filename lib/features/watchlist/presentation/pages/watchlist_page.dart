import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/features/watchlist/presentation/pages/watchlist_movies_page.dart';
import 'package:movie_app/features/watchlist/presentation/pages/watchlist_tv_page.dart';

class WatchlistPage extends StatelessWidget {
  static const ROUTE_NAME = '/watchlist-page';
  const WatchlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: SafeArea(
        child: Container(
          margin: EdgeInsets.all(8),
          child: Scaffold(
            appBar: TabBar(
                indicatorColor: kMikadoYellow,
                unselectedLabelColor: Colors.white.withOpacity(0.5),
                indicatorWeight: 3,
                tabs: [
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
              physics: BouncingScrollPhysics(),
              dragStartBehavior: DragStartBehavior.down,
              children: [WatchlistMoviesPage(), WatchlistTvPage()],
            ),
          ),
        ),
      ),
    );
  }
}
