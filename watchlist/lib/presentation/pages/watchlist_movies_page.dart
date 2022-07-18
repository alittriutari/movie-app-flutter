import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_list_with_title.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';

class WatchlistMoviesPage extends StatefulWidget {
  const WatchlistMoviesPage({Key? key}) : super(key: key);

  @override
  _WatchlistMoviesPageState createState() => _WatchlistMoviesPageState();
}

class _WatchlistMoviesPageState extends State<WatchlistMoviesPage> with RouteAware {
  @override
  void initState() {
    super.initState();
    context.read<WatchlistMovieBloc>().add(GetWatchlistMovieEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<WatchlistMovieBloc, WatchlistMovieState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case WatchlistMovieLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case WatchlistMovieFailure:
                final _failure = (state as WatchlistMovieFailure).failure;
                return Center(child: Text(_failure.message));
              case WatchlistMovieLoaded:
                final movie = (state as WatchlistMovieLoaded).movie;
                return MovieListGrid(movie);
              case WatchlistMovieInitial:
                return Center(
                    child: Text(
                  'Your watchlist is empty',
                  style: kSubtitle,
                ));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
