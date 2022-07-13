import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/movie_card_list.dart';
import 'package:search/presentation/bloc/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search_bloc.dart';
import 'package:tv_series/presentation/widget/tv_series_card_list.dart';

class SearchPage extends StatelessWidget {
  static const routeName = '/search';
  final int index;

  const SearchPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              onSubmitted: (query) {
                switch (index) {
                  case 0:
                    // Provider.of<SearchMovieNotifier>(context, listen: false)
                    //     .fetchMovieSearch(query);
                    context
                        .read<MovieSearchBloc>()
                        .add(GetMovieSearchEvent(query: query));
                    break;
                  case 1:
                    // Provider.of<SearchTvSeriesNotifier>(context, listen: false).fetchTvSeriesSearch(query);
                    context
                        .read<TvSearchBloc>()
                        .add(GetTvSearchEvent(query: query));
                    break;
                  default:
                }
              },
              decoration: const InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Search Result for ',
                  style: kHeading6,
                ),
                Text(
                  index == 0 ? 'Movies' : 'Tv Series',
                  style: kHeading6.copyWith(color: kMikadoYellow),
                ),
              ],
            ),
            if (index == 0) ...[
              BlocBuilder<MovieSearchBloc, MovieSearchState>(
                builder: (context, state) {
                  if (state.runtimeType == MovieSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.runtimeType == MovieSearchLoaded) {
                    final result = (state as MovieSearchLoaded).data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = result[index];
                          return MovieCard(movie);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else if (state.runtimeType == MovieSearchFailure) {
                    final failure = (state as MovieSearchFailure).failure;
                    return Text(failure.message);
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              )
              // Consumer<SearchMovieNotifier>(
              //   builder: (context, data, child) {
              //     if (data.state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (data.state == RequestState.Loaded) {
              // final result = data.searchResult;
              // return Expanded(
              //   child: ListView.builder(
              //     padding: const EdgeInsets.all(8),
              //     itemBuilder: (context, index) {
              //       final movie = data.searchResult[index];
              //       return MovieCard(movie);
              //     },
              //     itemCount: result.length,
              //   ),
              // );
              //     } else {
              // return Expanded(
              //   child: Container(),
              // );
              //     }
              //   },
              // ),
            ] else if (index == 1) ...[
              BlocBuilder<TvSearchBloc, TvSearchState>(
                builder: (context, state) {
                  if (state.runtimeType == TvSearchLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state.runtimeType == TvSearchLoaded) {
                    final result = (state as TvSearchLoaded).data;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = result[index];
                          return TvSeriesCard(tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else if (state.runtimeType == TvSearchFailure) {
                    final failure = (state as TvSearchFailure).failure;
                    return Text(failure.message);
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              )
              // Consumer<SearchTvSeriesNotifier>(
              //   builder: (context, data, child) {
              //     if (data.state == RequestState.Loading) {
              //       return Center(
              //         child: CircularProgressIndicator(),
              //       );
              //     } else if (data.state == RequestState.Loaded) {
              //       final result = data.searchResult;
              //       return Expanded(
              //         child: ListView.builder(
              //           padding: const EdgeInsets.all(8),
              //           itemBuilder: (context, index) {
              //             final tv = data.searchResult[index];
              //             return TvSeriesCard(tv);
              //           },
              //           itemCount: result.length,
              //         ),
              //       );
              //     } else {
              //       return Expanded(
              //         child: Container(),
              //       );
              //     }
              //   },
              // ),
            ],
          ],
        ),
      ),
    );
  }
}
