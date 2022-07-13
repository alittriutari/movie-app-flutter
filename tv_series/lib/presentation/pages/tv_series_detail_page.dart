import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:tv_series/domain/entities/tv_series_detail.dart';
import 'package:tv_series/presentation/bloc/episode_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  static const routeName = '/tv-series-detail';
  final int id;

  const TvSeriesDetailPage({Key? key, required this.id}) : super(key: key);

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<TvDetailBloc>().add(GetTvDetailEvent(widget.id));
      context
          .read<RecommendationTvBloc>()
          .add(GetRecommendationTvEvent(widget.id));
      context.read<WatchlistTvBloc>().add(LoadWatchlistTvEvent(widget.id));
      context
          .read<EpisodeBloc>()
          .add(GetEpisodeEvent(id: widget.id, seasonNumber: 1));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedWatchlist = context.select<WatchlistTvBloc, bool>(
      (value) => (value.state is WatchlistTvChanged)
          ? (value.state as WatchlistTvChanged).status
          : (value.state is WatchlistTvChanged)
              ? false
              : true,
    );

    return Scaffold(
      body: BlocBuilder<TvDetailBloc, TvDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case TvDetailLoading:
              return const Center(
                child: CircularProgressIndicator(),
              );
            case TvDetailFailure:
              final _msg = (state as TvDetailFailure).failure;
              return Text(_msg.toString());
            case TvDetailLoaded:
              final tvSeries = (state as TvDetailLoaded).data;
              final season = tvSeries.numberOfSeasons;
              return SafeArea(
                child: DetailTvSeriesContent(
                  seasons: season,
                  tvSeries: tvSeries,
                  isAddedWatchlist: isAddedWatchlist,
                ),
              );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailTvSeriesContent extends StatefulWidget {
  final TvSeriesDetail tvSeries;
  final int seasons;
  bool isAddedWatchlist;

  DetailTvSeriesContent(
      {Key? key,
      required this.tvSeries,
      required this.isAddedWatchlist,
      required this.seasons})
      : super(key: key);

  @override
  State<DetailTvSeriesContent> createState() => _DetailTvSeriesContentState();
}

class _DetailTvSeriesContentState extends State<DetailTvSeriesContent>
    with SingleTickerProviderStateMixin {
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
    final message = context.select<WatchlistTvBloc, String>(
        (value) => (value.state is WatchlistTvChanged)
            ? (value.state as WatchlistTvChanged).status == false
                ? watchlistAddSuccessMessage
                : watchlistRemoveSuccessMessage
            : !widget.isAddedWatchlist
                ? watchlistAddSuccessMessage
                : watchlistRemoveSuccessMessage);

    return CustomScrollView(
      physics: const BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 400,
                    child: CustomCacheImage(
                      imageUrl:
                          'https://image.tmdb.org/t/p/w500${widget.tvSeries.posterPath}',
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
                    bottom: 120,
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
                        textAlign: TextAlign.center,
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
                            context
                                .read<WatchlistTvBloc>()
                                .add(AddWatchlistTvEvent(widget.tvSeries));
                          } else {
                            context
                                .read<WatchlistTvBloc>()
                                .add(RemoveWatchlistTvEvent(widget.tvSeries));
                          }

                          if (message == watchlistAddSuccessMessage ||
                              message == watchlistRemoveSuccessMessage) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(SnackBar(content: Text(message)));
                          } else {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    content: Text(message),
                                  );
                                });
                          }
                          setState(() {
                            widget.isAddedWatchlist = !widget.isAddedWatchlist;
                          });
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            widget.isAddedWatchlist
                                ? const Icon(Icons.check)
                                : const Icon(Icons.add),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.isAddedWatchlist
                                  ? 'Remove from watchlist'
                                  : 'Add to watchlist',
                              style: kBodyText.copyWith(
                                  fontWeight: FontWeight.bold),
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
                      itemBuilder: (context, index) => const Icon(
                        Icons.star,
                        color: kMikadoYellow,
                      ),
                      itemSize: 20,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        Text('${widget.tvSeries.numberOfSeasons} Season'),
                        const SizedBox(
                          width: 10,
                        ),
                        Container(
                            color: kDavysGrey,
                            padding: const EdgeInsets.all(5),
                            child: Text(
                              widget.tvSeries.episodeRunTime.isEmpty
                                  ? '0'
                                  : _showDuration(
                                      widget.tvSeries.episodeRunTime.first),
                            ))
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 16),
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
          child: TabBar(
              indicatorWeight: 3,
              indicatorColor: kMikadoYellow,
              controller: _tabController,
              tabs: [
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
          return _selectedIndex == 0
              ? SliverToBoxAdapter(child: _recommendationTvSeries())
              : SliverToBoxAdapter(child: _episodeTvSeries(context));
        }),
      ],
    );
  }

  Widget _recommendationTvSeries() {
    return BlocBuilder<RecommendationTvBloc, RecommendationTvState>(
      builder: (context, state) {
        switch (state.runtimeType) {
          case RecommendationTvLoading:
            return const Center(
              child: CircularProgressIndicator(),
            );
          case RecommendationTvFailure:
            final msg = (state as RecommendationTvFailure).failure;
            return Center(
              child: Text(msg.toString()),
            );
          case RecommendationTvLoaded:
            final _data = (state as RecommendationTvLoaded).data;
            return SizedBox(
              height: 150,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  final tv = _data[index];
                  return Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(
                          context,
                          TvSeriesDetailPage.routeName,
                          arguments: tv.id,
                        );
                      },
                      child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(8),
                        ),
                        child: CustomCacheImage(
                          imageUrl:
                              'https://image.tmdb.org/t/p/w500${tv.posterPath}',
                          width: 90,
                        ),
                      ),
                    ),
                  );
                },
                itemCount: _data.length,
              ),
            );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _episodeTvSeries(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
      child: Column(mainAxisSize: MainAxisSize.max, children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.06,
          width: double.infinity,
          margin: const EdgeInsets.symmetric(vertical: 16),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 5),
          decoration: BoxDecoration(
              color: kDavysGrey, borderRadius: BorderRadius.circular(10)),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<int>(
                value: currentSeason,
                hint: const Text('Select season'),
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
                  context.read<EpisodeBloc>().add(GetEpisodeEvent(
                      id: widget.tvSeries.id, seasonNumber: currentSeason));
                }),
          ),
        ),
        BlocBuilder<EpisodeBloc, EpisodeState>(builder: (context, state) {
          switch (state.runtimeType) {
            case EpisodeLoading:
              return const CircularProgressIndicator();
            case EpisodeFailure:
              final _msg = (state as EpisodeFailure).failure;
              return Text(_msg.toString());
            case EpisodeLoaded:
              final data = (state as EpisodeLoaded).data;
              if (data.isEmpty) {
                return const SizedBox(
                    height: 50, child: Center(child: Text('Not Available')));
              } else {
                return ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(
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
                              imageUrl: baseImageUrl + data[index].stillPath,
                              height: 80,
                              width: 100,
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(data[index].name),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      color: kDavysGrey,
                                      child: Text(
                                          data[index].voteAverage.toString())),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Text(
                          data[index].overview,
                          style: description,
                        ),
                      ],
                    );
                  },
                  itemCount: data.length,
                );
              }
          }
          return const SizedBox.shrink();
        })
      ]),
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
