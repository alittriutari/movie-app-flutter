import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/domain/entities/genre.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series_detail.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
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
            final season = tvSeries.numberOfSeasons;
            return SafeArea(
              child: DetailTvSeriesContent(
                tvSeries: tvSeries,
                recommendations: recommendation,
                isAddedWatchlist: provider.isAddedToWatchlist,
                seasons: season,
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
  final int seasons;
  final bool isAddedWatchlist;

  DetailTvSeriesContent({required this.tvSeries, required this.recommendations, required this.isAddedWatchlist, required this.seasons});

  @override
  State<DetailTvSeriesContent> createState() => _DetailTvSeriesContentState();
}

class _DetailTvSeriesContentState extends State<DetailTvSeriesContent> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<int> _seasonList = [];
  int currentSeason = 1;
  int _selectedIndex = 0;
  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    for (var i = 1; i <= widget.seasons; i++) {
      _seasonList.add(i);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: SizedBox(
              // height: 400,
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
                      right: 16,
                      left: 16,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () async {
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
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                            SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.isAddedWatchlist ? 'Remove from watchlist' : 'Add to watchlist',
                              style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ))
                ],
              ),
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RatingBarIndicator(
                      rating: widget.tvSeries.voteAverage / 2,
                      itemCount: 5,
                      itemBuilder: (context, index) => Icon(
                        Icons.star,
                        color: kMikadoYellow,
                      ),
                      itemSize: 20,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('${widget.tvSeries.numberOfSeasons} Season'),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                            color: kDavysGrey,
                            padding: EdgeInsets.all(5),
                            child: Text(
                              _showDuration(widget.tvSeries.episodeRunTime.first),
                            ))
                      ],
                    ),
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
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: TabBar(indicatorWeight: 3, indicatorColor: kMikadoYellow, controller: _tabController, tabs: [
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text('Recommendations'.toUpperCase()),
              ),
            ),
            Tab(
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  'Episode'.toUpperCase(),
                ),
              ),
            ),
          ]),
        ),
        Builder(builder: (context) {
          _tabController.addListener(() {
            if (!_tabController.indexIsChanging) {
              setState(() {
                _selectedIndex = _tabController.index;
              });
            }
          });
          return _selectedIndex == 0 ? SliverToBoxAdapter(child: _recommendationTvSeries()) : SliverToBoxAdapter(child: _episodeTvSeries(context));
        }),
      ],
    );
  }

  Widget _recommendationTvSeries() {
    return Consumer<TvSeriesDetailNotifier>(
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
            margin: const EdgeInsets.fromLTRB(16, 25, 16, 16),
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
    );
  }

  Widget _episodeTvSeries(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Container(
            height: MediaQuery.of(context).size.height * 0.06,
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 16),
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
            decoration: BoxDecoration(color: kDavysGrey, borderRadius: BorderRadius.circular(10)),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<int>(
                  value: currentSeason,
                  hint: Text('Select season'),
                  isExpanded: true,
                  items: _seasonList
                      .map((e) => DropdownMenuItem<int>(
                            value: e,
                            child: Text('Season ' + e.toString()),
                          ))
                      .toList(),
                  onChanged: (value) {
                    setState(() {
                      currentSeason = value!;
                    });
                    Provider.of<TvEpisodeNotifier>(context, listen: false).fetchEpisode(widget.tvSeries.id, currentSeason);
                  }),
            ),
          ),
          Consumer<TvEpisodeNotifier>(
            builder: (context, data, child) {
              if (data.episodeState == RequestState.Error) {
                return Text(data.message);
              } else if (data.episodeState == RequestState.Loaded) {
                if (data.episode.isEmpty) {
                  return Container(height: 50, child: Center(child: Text('Not Available')));
                } else {
                  return ListView.separated(
                    separatorBuilder: (context, index) => SizedBox(
                      height: 8,
                    ),
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CustomCacheImage(
                                imageUrl: BASE_IMAGE_URL + data.episode[index].stillPath,
                                height: 80,
                                width: 100,
                              ),
                              SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data.episode[index].name),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Container(padding: EdgeInsets.all(5), color: kDavysGrey, child: Text(data.episode[index].voteAverage.toString())),
                                ],
                              ),
                            ],
                          ),
                          Text(
                            data.episode[index].overview,
                            style: description,
                          ),
                        ],
                      );
                    },
                    itemCount: data.episode.length,
                  );
                }
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
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
