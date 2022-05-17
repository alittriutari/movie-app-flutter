import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/state_enum.dart';
import 'package:movie_app/features/movies/domain/entities/genre.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/domain/entities/movie_detail.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:provider/provider.dart';

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
      Provider.of<MovieDetailNotifier>(context, listen: false).fetchMovieDetail(widget.id);
      Provider.of<MovieDetailNotifier>(context, listen: false).loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<MovieDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.movieState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.movieState == RequestState.Loaded) {
            final movie = provider.movie;
            return SafeArea(
              child: DetailContent(
                movie,
                provider.movieRecommendations,
                provider.isAddedToWatchlist,
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

class DetailContent extends StatelessWidget {
  final MovieDetail movie;
  final List<Movie> recommendations;
  final bool isAddedWatchlist;

  DetailContent(this.movie, this.recommendations, this.isAddedWatchlist);

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
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 400,
                    child: CustomCacheImage(
                      imageUrl: 'https://image.tmdb.org/t/p/w500${movie.posterPath}',
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
                          movie.title,
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
                        _showGenres(movie.genres),
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
                        if (!isAddedWatchlist) {
                          await Provider.of<MovieDetailNotifier>(context, listen: false).addWatchlist(movie);
                        } else {
                          await Provider.of<MovieDetailNotifier>(context, listen: false).removeFromWatchlist(movie);
                        }

                        final message = Provider.of<MovieDetailNotifier>(context, listen: false).watchlistMessage;

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
                          isAddedWatchlist ? Icon(Icons.check) : Icon(Icons.add),
                          SizedBox(
                            width: 5,
                          ),
                          Text(
                            isAddedWatchlist ? 'Remove from watchlist' : 'Add to watchlist',
                            style: kBodyText.copyWith(fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                  )
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
                      rating: movie.voteAverage / 2,
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
                          _showDuration(movie.runtime),
                        )),
                  ],
                ),
                SizedBox(height: 16),
                Text(
                  'Overview',
                  style: kHeading6,
                ),
                Text(
                  movie.overview,
                ),
                SizedBox(height: 16),
                Text(
                  'Recommendations',
                  style: kHeading6,
                ),
                Consumer<MovieDetailNotifier>(
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
                            final movie = recommendations[index];
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
                          itemCount: recommendations.length,
                        ),
                      );
                    } else {
                      return Center(child: Text('Data not found'));
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
