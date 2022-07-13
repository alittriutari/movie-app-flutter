import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/movie.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import 'custom_cache_image.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  const MovieList(this.movies, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: InkWell(
              key: const Key('show_movie_detail'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.routeName,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
                child: CustomCacheImage(
                    imageUrl: '$baseImageUrl${movie.posterPath}', width: 90),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
