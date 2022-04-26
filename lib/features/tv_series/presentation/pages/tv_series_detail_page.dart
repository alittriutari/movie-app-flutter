import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/domain/entities/genre.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/tv-series-detail';
  final int id;

  TvSeriesDetailPage({required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => Provider.of<TvSeriesDetailNotifier>(context, listen: false).fetchTvSeriesDetail(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TvSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final tvSeries = provider.tvSeries;
            final recommendation = provider.tvSeriesRecommendation;
            return SafeArea(
              child: DetailTvSeriesContent(
                tvSeries: tvSeries,
                recommendations: recommendation,
                isAddedWatchlist: provider.isAddedToWatchlist,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailTvSeriesContent extends StatelessWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final bool isAddedWatchlist;

  DetailTvSeriesContent({required this.tvSeries, required this.recommendations, required this.isAddedWatchlist});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: SizedBox(
            height: 400,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  height: 400,
                  child: CustomCacheImage(
                    imageUrl: 'https://image.tmdb.org/t/p/w500${tvSeries.posterPath}',
                    height: 400,
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                  ),
                ),
                Container(
                  height: 400,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Colors.black, Colors.transparent],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter,
                    ),
                  ),
                ),
                Positioned(
                  bottom: 100,
                  child: SizedBox(
                      width: 250,
                      child: Text(
                        tvSeries.name,
                        textAlign: TextAlign.center,
                        style: kHeading5,
                      )),
                ),
                Positioned(
                  bottom: 75,
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      _showGenres(tvSeries.genres),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (!isAddedWatchlist) {
                          await Provider.of<TvSeriesDetailNotifier>(context, listen: false).addWatchList(tvSeries);
                        } else {
                          await Provider.of<TvSeriesDetailNotifier>(context, listen: false).removeFromWatchlist(tvSeries);
                        }

                        final message = Provider.of<TvSeriesDetailNotifier>(context, listen: false).watchlistMessage;

                        if (message == watchlistAddSuccessMessage || message == watchlistRemoveSuccessMessage) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
                        } else {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  content: Text(message),
                                );
                              });
                        }
                      },
                      child: Column(
                        children: [
                          isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                          Text(
                            'Watchlist',
                            style: kBodyText,
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 20,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        RatingBarIndicator(
                          rating: tvSeries.voteAverage / 2,
                          itemCount: 5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: kMikadoYellow,
                          ),
                          itemSize: 24,
                        ),
                        Text('${tvSeries.voteAverage}')
                      ],
                    ),
                    // SizedBox(
                    //   width: 20,
                    // ),
                    // Container(
                    //   color: kDavysGrey,
                    //   padding: EdgeInsets.all(5),
                    //   child: Text(
                    //     _showDuration(tvSeries.),
                    //   ),
                    // ),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(
                  tvSeries.overview,
                ),
                SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: kHeading6,
                ),
                Consumer<TvSeriesDetailNotifier>(
                  builder: (context, data, child) {
                    if (data.recommendationState == RequestState.Loading) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (data.recommendationState == RequestState.Error) {
                      return Text(data.message);
                    } else if (data.recommendationState == RequestState.Loaded) {
                      return Container(
                        height: 150,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            final tv = recommendations[index];
                            return Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushReplacementNamed(
                                    context,
                                    TvSeriesDetailPage.ROUTE_NAME,
                                    arguments: tv.id,
                                  );
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                  child: CustomCacheImage(
                                    imageUrl: 'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                                    width: 90,
                                  ),
                                ),
                              ),
                            );
                          },
                          itemCount: recommendations.length,
                        ),
                      );
                    } else {
                      return Container();
                    }
                  },
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
}
