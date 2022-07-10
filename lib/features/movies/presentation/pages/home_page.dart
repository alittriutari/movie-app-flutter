import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/features/movies/presentation/pages/home_movie_page.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_drawer.dart';
import 'package:movie_app/features/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:movie_app/features/watchlist/presentation/pages/watchlist_page.dart';

import '../../../search/presentation/pages/search_page.dart';

class HomeScreen extends StatelessWidget {
  final int selectedIndex;
  const HomeScreen({Key? key, required this.selectedIndex}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double scrollOffset = 120.0;
    final _advancedDrawerController = AdvancedDrawerController();
    final Size screenSize = MediaQuery.of(context).size;
    return AdvancedDrawer(
      backdropColor: kDavysGrey,
      controller: _advancedDrawerController,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      animateChildDecoration: true,
      rtlOpening: false,
      disabledGestures: false,
      drawer: CustomDrawer(),
      child: DefaultTabController(
        initialIndex: selectedIndex,
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
                    padding: EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                key: Key('drawer_icon'),
                                onPressed: () {
                                  _advancedDrawerController.showDrawer();
                                },
                                icon: Icon(Icons.menu)),
                            SizedBox(
                              width: 10,
                            ),
                            Text('Movie App'),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.camera_outdoor),
                            Expanded(child: SizedBox()),
                            IconButton(
                                key: Key('search_icon'),
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
            body: TabBarView(children: [HomeMoviePage(), HomeTvSeriesPage(), WatchlistPage()]),
          );
        }),
      ),
    );
  }
}
