import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import 'custom_cache_image.dart';

class MovieListGrid extends StatelessWidget {
  final List<Movie> movies;

  const MovieListGrid(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return movies.isEmpty
        ? Center(
            child: Text(
            'Your watchlist is empty',
            style: kSubtitle,
          ))
        : GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisSpacing: 8.0,
              childAspectRatio: 0.47,
              crossAxisCount: 3,
            ),
            shrinkWrap: true,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context,
                    MovieDetailPage.routeName,
                    arguments: movie.id,
                  );
                },
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomCacheImage(
                        imageUrl: '$baseImageUrl${movie.posterPath}',
                        width: 100,
                        height: 180,
                      ),
                      Text(
                        movie.title ?? '',
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                      )
                    ],
                  ),
                ),
              );
            },
            itemCount: movies.length,
          );
  }
}
