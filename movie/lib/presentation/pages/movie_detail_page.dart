import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';

class MovieDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail';

  final int id;
  MovieDetailPage({required this.id});

  @override
  _MovieDetailPageState createState() => _MovieDetailPageState();
}

class _MovieDetailPageState extends State<MovieDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<MovieDetailBloc>().add(GetMovieDetailEvent(widget.id));
      context.read<RecommendationMovieBloc>().add(GetRecommendationMovieEvent(widget.id));

      context.read<WatchlistMovieBloc>().add(LoadWatchlistMovieEvent(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    bool isAddedWatchlist = context.select<WatchlistMovieBloc, bool>(
      (value) => (value.state is WatchlistMovieChanged)
          ? (value.state as WatchlistMovieChanged).status
          : (value.state is WatchlistMovieChanged)
              ? false
              : true,
    );
    return Scaffold(
      body: BlocBuilder<MovieDetailBloc, MovieDetailState>(
        builder: (context, state) {
          switch (state.runtimeType) {
            case MovieDetailLoading:
              return Center(
                child: CircularProgressIndicator(),
              );
            case MovieDetailFailure:
              final _msg = (state as MovieDetailFailure).failure;
              return Text(_msg.toString());
            case MovieDetailLoaded:
              final _data = (state as MovieDetailLoaded).data;
              return SafeArea(
                child: DetailContent(
                  _data,
                  isAddedWatchlist,
                ),
              );
          }

          return SizedBox.shrink();
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final MovieDetail movie;
  bool isAddedWatchlist;
  DetailContent(this.movie, this.isAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final message = context.select<WatchlistMovieBloc, String>((value) => (value.state is WatchlistMovieChanged)
        ? (value.state as WatchlistMovieChanged).status == false
            ? watchlistAddSuccessMessage
            : watchlistRemoveSuccessMessage
        : !widget.isAddedWatchlist
            ? watchlistAddSuccessMessage
            : watchlistRemoveSuccessMessage);

    return CustomScrollView(
      physics: BouncingScrollPhysics(),
      slivers: [
        SliverAppBar(
          expandedHeight: 400,
          pinned: true,
          flexibleSpace: FlexibleSpaceBar(
            background: SizedBox(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 400,
                    child: CustomCacheImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${widget.movie.posterPath}',
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
                          widget.movie.title,
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
                        _showGenres(widget.movie.genres),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Builder(builder: (context) {
                    return Positioned(
                      bottom: 20,
                      right: 16,
                      left: 16,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          if (!widget.isAddedWatchlist) {
                            context.read<WatchlistMovieBloc>().add(AddWatchlistMovieEvent(widget.movie));
                          } else {
                            context.read<WatchlistMovieBloc>().add(RemoveWatchlistMovieEvent(widget.movie));
                          }

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
                          setState(() {
                            widget.isAddedWatchlist = !widget.isAddedWatchlist;
                          });
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
                      ),
                    );
                  })
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
                      rating: widget.movie.voteAverage / 2,
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
                    Container(
                        color: kDavysGrey,
                        padding: EdgeInsets.all(5),
                        child: Text(
                          _showDuration(widget.movie.runtime),
                        )),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(
                  widget.movie.overview,
                ),
                SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: kHeading6,
                ),
                BlocBuilder<RecommendationMovieBloc, RecommendationMovieState>(
                  builder: (context, state) {
                    switch (state.runtimeType) {
                      case RecommendationMovieLoading:
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      case RecommendationMovieFailure:
                        final msg = (state as RecommendationMovieFailure).failure;
                        return Center(
                          child: Text(msg.toString()),
                        );
                      case RecommendationMovieLoaded:
                        final _data = (state as RecommendationMovieLoaded).data;
                        return Container(
                          height: 150,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              final movie = _data[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.pushReplacementNamed(
                                      context,
                                      MovieDetailPage.ROUTE_NAME,
                                      arguments: movie.id,
                                    );
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(8),
                                    ),
                                    child: CustomCacheImage(
                                      imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                    return SizedBox.shrink();
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
