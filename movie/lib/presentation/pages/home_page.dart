import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advanced_drawer/flutter_advanced_drawer.dart';
import 'package:movie/presentation/pages/home_movie_page.dart';
import 'package:movie/presentation/widgets/custom_drawer.dart';
import 'package:search/search.dart';
import 'package:tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:watchlist/watchlist.dart';

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
      drawer: const CustomDrawer(),
      child: DefaultTabController(
        initialIndex: selectedIndex,
        length: 3,
        child: Builder(builder: (context) {
          return Scaffold(
            extendBodyBehindAppBar: true,
            appBar: PreferredSize(
              preferredSize: Size(screenSize.width, 100),
              child: Container(
                color:
                    Colors.black.withOpacity((scrollOffset / 350).clamp(0, 1)),
                child: SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 20, 10),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            IconButton(
                                key: const Key('drawer_icon'),
                                onPressed: () {
                                  _advancedDrawerController.showDrawer();
                                },
                                icon: const Icon(Icons.menu)),
                            const SizedBox(
                              width: 10,
                            ),
                            const Text('Movie App'),
                            const SizedBox(
                              width: 5,
                            ),
                            const Icon(Icons.camera_outdoor),
                            const Expanded(child: SizedBox()),
                            IconButton(
                                key: const Key('search_icon'),
                                onPressed: () {
                                  Navigator.pushNamed(
                                    context,
                                    SearchPage.routeName,
                                    arguments:
                                        DefaultTabController.of(context)!.index,
                                  );
                                },
                                icon: const Icon(Icons.search))
                          ],
                        ),
                        const Spacer(),
                        const TabBar(indicatorColor: Colors.transparent, tabs: [
                          Text('Movie'),
                          Text('Tv Series'),
                          Text('Watchlist')
                        ])
                      ],
                    ),
                  ),
                ),
              ),
            ),
            body: const TabBarView(children: [
              HomeMoviePage(),
              HomeTvSeriesPage(),
              WatchlistPage()
            ]),
          );
        }),
      ),
    );
  }
}
