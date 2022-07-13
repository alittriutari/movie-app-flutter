import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

class TopRatedMoviesPage extends StatelessWidget {
  static const routeName = '/top-rated-movie';

  const TopRatedMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Top Rated Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<TopRatedMovieBloc, TopRatedMovieState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case TopRatedMovieLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case TopRatedMovieFailure:
                final _msg = (state as TopRatedMovieFailure).failure;
                return Center(
                  key: const Key('error_message'),
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
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
