import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app/features/movies/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie_app/features/movies/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const ROUTE_NAME = '/top-rated-movie';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TopRatedMovieLoading:
                return Center(
                  child: CircularProgressIndicator(),
                );
              case TopRatedMovieFailure:
                final _msg = (state as TopRatedMovieFailure).failure;
                return Center(
                  key: Key('error_message'),
                  child: Text(_msg.toString()),
                );
              case TopRatedMovieLoaded:
                final _data = (state as TopRatedMovieLoaded).data;
                return ListView.builder(
                  itemBuilder: (context, index) {
                    final movie = _data[index];
                    return MovieCard(movie);
                  },
                  itemCount: _data.length,
                );
            }
            return SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
