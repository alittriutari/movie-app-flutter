import 'package:movie_app/features/movies/presentation/pages/home_movie_page.dart';
import 'package:movie_app/features/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:flutter/material.dart';

import '../../../search/presentation/pages/search_page.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrollOffset = 120.0;
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Builder(builder: (context) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: PreferredSize(
            preferredSize: Size(screenSize.width, 100),
            child: Container(
              color: Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1)),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text('Movie App'),
                          SizedBox(
                            width: 5,
                          ),
                          Icon(Icons.camera_outdoor),
                          Expanded(child: SizedBox()),
                          IconButton(
                              onPressed: () {
                                Navigator.pushNamed(
                                  context,
                                  SearchPage.ROUTE_NAME,
                                  arguments: DefaultTabController.of(context)!.index,
                                );
                              },
                              icon: Icon(Icons.search))
                        ],
                      ),
                      Spacer(),
                      TabBar(indicatorColor: Colors.transparent, tabs: [Text('Movie'), Text('Tv Series'), Text('Watchlist')])
                    ],
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(children: [HomeMoviePage(), HomeTvSeriesPage(), Text('hahah')]),
        );
      }),
    );
  }
}
