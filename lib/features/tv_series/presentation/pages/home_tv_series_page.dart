import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:movie_app/features/movies/presentation/widgets/sub_heading_widget.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:movie_app/features/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/widget/carrousel_tv_series_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../common/constants.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  double _scrollOffset = 0.0;
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController()
      ..addListener(() {
        _scrollOffset = _controller.offset;
      });

    Future.microtask(
        () => Provider.of<TvSeriesListNotifier>(context, listen: false)
          ..fetchOnAirTvSeries()
          ..fetchPopularTvSeries());
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
        child: Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
          final state = data.onAirState;
          if (state == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state == RequestState.Loaded) {
            return CarrouselTvSeriesWidget(
              tvSeries: data.onAirTvSeries,
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
              SubHeadingWidget(
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(
                      context, PopularTvSeriesPage.ROUTE_NAME)),
              Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
                final state = data.popularTvSeriesState;
                if (state == RequestState.Loading) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else if (state == RequestState.Loaded) {
                  return TvSeriesList(data.popularTvSeries);
                } else {
                  return Text('Failed');
                }
              }),
              // SubHeadingWidget(title: 'Top Rated', onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME)),
              // Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
              //   final state = data.topRatedMoviesState;
              //   if (state == RequestState.Loading) {
              //     return Center(
              //       child: CircularProgressIndicator(),
              //     );
              //   } else if (state == RequestState.Loaded) {
              //     return MovieList(data.topRatedMovies);
              //   } else {
              //     return Text('Failed');
              //   }
              // }),
            ],
          ),
        ),
      ),
    ]);
    // return Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: SingleChildScrollView(
    //     child: Column(
    //       crossAxisAlignment: CrossAxisAlignment.start,
    //       children: [
    //         // // Padding(
    //         // //   padding: const EdgeInsets.symmetric(vertical: 8),
    //         // //   child: Text(
    //         // //     'Now Playing',
    //         // //     style: kHeading6,
    //         // //   ),
    //         // // ),
    //         // _buildSubHeading(
    //         //   title: 'On Airing',
    //         //   onTap: () => Navigator.pushNamed(context, OnAirTvSeriesPage.ROUTE_NAME),
    //         // ),
    //         Consumer<TvSeriesListNotifier>(
    //           builder: (context, data, child) {
    //             final state = data.onAirState;
    //             if (state == RequestState.Loading) {
    //               return Center(
    //                 child: CircularProgressIndicator(),
    //               );
    //             } else if (state == RequestState.Loaded) {
    //               return CarrouselTvSeriesWidget(tvSeries: data.onAirTvSeries);
    //             } else {
    //               return Text('Failed');
    //             }
    //           },
    //         ),
    //         SubHeadingWidget(title: 'Popular', onTap: () => Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME)),
    //         Consumer<TvSeriesListNotifier>(builder: (context, data, child) {
    //           final state = data.popularTvSeriesState;
    //           if (state == RequestState.Loading) {
    //             return Center(
    //               child: CircularProgressIndicator(),
    //             );
    //           } else if (state == RequestState.Loaded) {
    //             return TvSeriesList(data.popularTvSeries);
    //           } else {
    //             return Text('Failed');
    //           }
    //         }),
    //       ],
    //     ),
    //   ),
    // );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(context, TvSeriesDetailPage.ROUTE_NAME,
                    arguments: series.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CustomCacheImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  width: 90,
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
