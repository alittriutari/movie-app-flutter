import 'package:ditonton/features/movies/presentation/pages/popular_movies_page.dart';

import 'package:ditonton/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/features/movies/presentation/widgets/carrousel_movie_widget.dart';
import 'package:ditonton/features/movies/presentation/widgets/custom_drawer.dart';
import 'package:ditonton/features/movies/presentation/widgets/sub_heading_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/movie_list_widget.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  double _scrollOffset = 0.0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        _scrollOffset = _controller.offset;
      });

    Future.microtask(() => Provider.of<MovieListNotifier>(context, listen: false)
      ..fetchNowPlayingMovies()
      ..fetchPopularMovies()
      ..fetchTopRatedMovies());
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _controller, slivers: [
      SliverToBoxAdapter(
        child: Consumer<MovieListNotifier>(builder: (context, data, child) {
          final state = data.nowPlayingState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return CarrouselMovieWidget(
              movies: data.nowPlayingMovies,
            );
          } else {
            return Text('Failed');
          }
        }),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              Text('top rated'),
              Container(
                height: 200,
                child: ListView.builder(
                  itemCount: 2,
                  // shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 100,
                      margin: EdgeInsets.all(8),
                      child: Image.network('https://lumiere-a.akamaihd.net/v1/images/p_aladdin2019_17638_d53b09e6.jpeg'),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    ]);
  }
}

// class HomeMoviePage extends StatefulWidget {
//   @override
//   _HomeMoviePageState createState() => _HomeMoviePageState();
// }

// class _HomeMoviePageState extends State<HomeMoviePage> {
//   @override
//   void initState() {
//     super.initState();
    // Future.microtask(
    //     () => Provider.of<MovieListNotifier>(context, listen: false)
    //       ..fetchNowPlayingMovies()
    //       ..fetchPopularMovies()
    //       ..fetchTopRatedMovies());
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Material(
//       child: CustomDrawer(
//         content: Scaffold(
//           body: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: SingleChildScrollView(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Consumer<MovieListNotifier>(builder: (context, data, child) {
//                     final state = data.nowPlayingState;
//                     if (state == RequestState.Loading) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state == RequestState.Loaded) {
//                       return CarrouselMovieWidget(
//                         movies: data.nowPlayingMovies,
//                       );
//                     } else {
//                       return Text('Failed');
//                     }
//                   }),
//                   SubHeadingWidget(
//                       title: 'Popular',
//                       onTap: () => Navigator.pushNamed(
//                           context, PopularMoviesPage.ROUTE_NAME)),
//                   Consumer<MovieListNotifier>(builder: (context, data, child) {
//                     final state = data.popularMoviesState;
//                     if (state == RequestState.Loading) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state == RequestState.Loaded) {
//                       return MovieList(data.popularMovies);
//                     } else {
//                       return Text('Failed');
//                     }
//                   }),
//                   SubHeadingWidget(
//                       title: 'Top Rated',
//                       onTap: () => Navigator.pushNamed(
//                           context, TopRatedMoviesPage.ROUTE_NAME)),
//                   Consumer<MovieListNotifier>(builder: (context, data, child) {
//                     final state = data.topRatedMoviesState;
//                     if (state == RequestState.Loading) {
//                       return Center(
//                         child: CircularProgressIndicator(),
//                       );
//                     } else if (state == RequestState.Loaded) {
//                       return MovieList(data.topRatedMovies);
//                     } else {
//                       return Text('Failed');
//                     }
//                   }),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
