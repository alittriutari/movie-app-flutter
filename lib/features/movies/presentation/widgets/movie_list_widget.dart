import 'package:movie_app/common/constants.dart';
import 'package:movie_app/features/movies/domain/entities/movie.dart';
import 'package:movie_app/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                child: CustomCacheImage(
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}', width: 90),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
