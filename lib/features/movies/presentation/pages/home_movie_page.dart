import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:movie_app/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_app/features/movies/presentation/widgets/carrousel_movie_widget.dart';
import 'package:movie_app/features/movies/presentation/widgets/placeholder_widget.dart';
import 'package:movie_app/features/movies/presentation/widgets/sub_heading_widget.dart';

import '../widgets/movie_list_widget.dart';

class HomeMoviePage extends StatefulWidget {
  const HomeMoviePage({Key? key}) : super(key: key);

  @override
  State<HomeMoviePage> createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  double scrollOffset = 0.0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        scrollOffset = _controller.offset;
      });
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
        child: BlocBuilder<NowPlayingMovieBloc, NowPlayingMovieState>(builder: (context, state) {
          switch (state.runtimeType) {
            case NowPlayingMovieLoading:
              return Center(
                child: PlaceholderWidget(
                  height: 400,
                  width: double.infinity,
                ),
              );
            case NowPlayingMovieFailure:
              final _msg = (state as NowPlayingMovieFailure).failure;
              return Center(
                key: Key('error_message'),
                child: Text(_msg.toString()),
              );
            case NowPlayingMovieLoaded:
              final _data = (state as NowPlayingMovieLoaded).data;
              return CarrouselMovieWidget(
                movies: _data,
              );
          }
          return SizedBox.shrink();
        }),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SubHeadingWidget(
                  key: Key('show_popular_movie'), title: 'Popular', onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME)),
              BlocBuilder<PopularMovieBloc, PopularMovieState>(builder: (context, state) {
                switch (state.runtimeType) {
                  case PopularMovieLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case PopularMovieFailure:
                    final _msg = (state as PopularMovieFailure).failure;
                    return Center(
                      key: Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case PopularMovieLoaded:
                    final _data = (state as PopularMovieLoaded).data;
                    return MovieList(_data);
                }
                return SizedBox.shrink();
              }),
              SubHeadingWidget(
                  key: Key('show_top_rated_movie'), title: 'Top Rated', onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME)),
              BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(builder: (context, state) {
                switch (state.runtimeType) {
                  case TopRatedMovieLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case TopRatedMovieFailure:
                    final _msg = (state as TopRatedMovieFailure).failure;
                    return Center(
                      key: Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case TopRatedMovieLoaded:
                    final _data = (state as TopRatedMovieLoaded).data;
                    return MovieList(_data);
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    ]);
  }
}
