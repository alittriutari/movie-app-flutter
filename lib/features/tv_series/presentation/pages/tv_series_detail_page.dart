import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/domain/entities/genre.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:movie_app/features/tv_series/domain/entities/episode.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
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
    Future.microtask(() {
      Provider.of<TvSeriesDetailNotifier>(context, listen: false).fetchTvSeriesDetail(widget.id);
      Provider.of<TvEpisodeNotifier>(context, listen: false).fetchEpisode(widget.id, 1);
    });
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
            final episode = tvSeries.numberOfEpisode;
            return SafeArea(
              child: DetailTvSeriesContent(
                tvSeries: tvSeries,
                recommendations: recommendation,
                isAddedWatchlist: provider.isAddedToWatchlist,
                episodes: episode,
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

class DetailTvSeriesContent extends StatefulWidget {
  final TvSeriesDetail tvSeries;
  final List<TvSeries> recommendations;
  final int episodes;
  final bool isAddedWatchlist;

  DetailTvSeriesContent({required this.tvSeries, required this.recommendations, required this.isAddedWatchlist, required this.episodes});

  @override
  State<DetailTvSeriesContent> createState() => _DetailTvSeriesContentState();
}

class _DetailTvSeriesContentState extends State<DetailTvSeriesContent> {
  List episodeList = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    for (var i = 1; i <= widget.episodes; i++) {
      episodeList.add(i);
    }
  }

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
                    imageUrl: 'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                        widget.tvSeries.name,
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
                      _showGenres(widget.tvSeries.genres),
                    ),
                  ),
                ),
                Positioned(
                    bottom: 20,
                    right: 0,
                    left: 0,
                    child: GestureDetector(
                      onTap: () async {
                        if (!widget.isAddedWatchlist) {
                          await Provider.of<TvSeriesDetailNotifier>(context, listen: false).addWatchList(widget.tvSeries);
                        } else {
                          await Provider.of<TvSeriesDetailNotifier>(context, listen: false).removeFromWatchlist(widget.tvSeries);
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
                          widget.isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
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
                          rating: widget.tvSeries.voteAverage / 2,
                          itemCount: 5,
                          itemBuilder: (context, index) => Icon(
                            Icons.star,
                            color: kMikadoYellow,
                          ),
                          itemSize: 24,
                        ),
                        Text('${widget.tvSeries.voteAverage}')
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
                  widget.tvSeries.overview,
                ),
                SizedBox(height: 16),
                DefaultTabController(
                  length: 2,
                  child: Column(
                    children: [
                      Container(
                        child: TabBar(indicatorColor: kMikadoYellow, unselectedLabelColor: Colors.white.withOpacity(0.5), indicatorWeight: 3, tabs: [
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Recommendations'),
                            ),
                          ),
                          Tab(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Episode'),
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                        child: TabBarView(
                          children: [
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
                                      shrinkWrap: true,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tv = widget.recommendations[index];
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
                                      itemCount: widget.recommendations.length,
                                    ),
                                  );
                                } else {
                                  return Center(child: Text('Data not found'));
                                }
                              },
                            ),
                            Column(
                              children: [
                                DropdownButtonFormField<int>(
                                    items: episodeList
                                        .map((e) => DropdownMenuItem<int>(
                                              value: e,
                                              child: Text(e.toString()),
                                            ))
                                        .toList(),
                                    onChanged: (value) {
                                      Provider.of<TvEpisodeNotifier>(context, listen: false).fetchEpisode(widget.tvSeries.id, value!);
                                    }),
                                Consumer<TvEpisodeNotifier>(
                                  builder: (context, data, child) {
                                    // if (data.episodeState == RequestState.Error) {
                                    //   return Text(data.message);
                                    // } else if (data.episodeState == RequestState.Loaded) {
                                    return Container(
                                      height: 20,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemBuilder: (context, index) {
                                          final eps = data.episode[index];
                                          print(episodeList);
                                          // return Text(eps.episodeNumber.toString());
                                          if (episodeList.first == 1) {
                                            return Text(data.episode[1].episodeNumber.toString());
                                          } else {
                                            return Text(data.episode[index].episodeNumber.toString());
                                          }
                                        },
                                        itemCount: episodeList.length,
                                      ),
                                    );
                                    // } else {
                                    //   return Center(child: CircularProgressIndicator());
                                    // }
                                  },
                                ),
                              ],
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                // Text(
                //   'Recommendations',
                //   style: kHeading6,
                // ),
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
