import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';

import '../bloc/popular_movie_bloc.dart';

class PopularMoviesPage extends StatelessWidget {
  static const routeName = '/popular-movie';

  const PopularMoviesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Popular Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<PopularMovieBloc, PopularMovieState>(
          builder: (context, state) {
            switch (state.runtimeType) {
              case PopularMovieLoading:
                return const Center(
                  child: CircularProgressIndicator(),
                );
              case PopularMovieFailure:
                final _msg = (state as PopularMovieFailure).failure;
                return Center(
                  key: const Key('error_message'),
                  child: Text(_msg.toString()),
                );
              case PopularMovieLoaded:
                final _data = (state as PopularMovieLoaded).data;
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
