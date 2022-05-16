import 'package:flutter/material.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/presentation/widgets/movie_card_list.dart';
import 'package:movie_app/features/search/presentation/provider/movie_search_notifier.dart';
import 'package:movie_app/features/search/presentation/provider/tv_series_search_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/widget/tv_series_card_list.dart';
import 'package:provider/provider.dart';

class SearchPage extends StatelessWidget {
  static const ROUTE_NAME = '/search';
  final int index;

  const SearchPage({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Search'),
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
                    Provider.of<SearchMovieNotifier>(context, listen: false).fetchMovieSearch(query);
                    break;
                  case 1:
                    Provider.of<SearchTvSeriesNotifier>(context, listen: false).fetchTvSeriesSearch(query);
                    break;
                  default:
                }
              },
              decoration: InputDecoration(
                hintText: 'Search title',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              textInputAction: TextInputAction.search,
            ),
            SizedBox(height: 16),
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
              Consumer<SearchMovieNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    final result = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final movie = data.searchResult[index];
                          return MovieCard(movie);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ] else if (index == 1) ...[
              Consumer<SearchTvSeriesNotifier>(
                builder: (context, data, child) {
                  if (data.state == RequestState.Loading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (data.state == RequestState.Loaded) {
                    final result = data.searchResult;
                    return Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8),
                        itemBuilder: (context, index) {
                          final tv = data.searchResult[index];
                          return TvSeriesCard(tv);
                        },
                        itemCount: result.length,
                      ),
                    );
                  } else {
                    return Expanded(
                      child: Container(),
                    );
                  }
                },
              ),
            ],
          ],
        ),
      ),
    );
  }
}
