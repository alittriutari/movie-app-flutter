import 'package:ditonton/features/movies/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double _scrollOffset = 0.0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        _scrollOffset = _controller.offset;
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: PreferredSize(
          preferredSize: Size(screenSize.width, 100),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Container(
                color: Colors.black.withOpacity((_scrollOffset / 350).clamp(0, 1)),
                child: SafeArea(
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
                          IconButton(onPressed: () {}, icon: Icon(Icons.search))
                        ],
                      ),
                      Spacer(),
                      TabBar(indicatorColor: Colors.transparent, tabs: [Text('Movie'), Text('Tv Series'), Text('Watchlist')])
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      //   children: [Text('Movie'), Text('Tv Series'), Text('Watchlist')],
                      // )
                    ],
                  ),
                )),
          ),
        ),
        body: TabBarView(children: [HomeMoviePage(), Text('jajj'), Text('hahah')]),
      ),
    );
  }
}
