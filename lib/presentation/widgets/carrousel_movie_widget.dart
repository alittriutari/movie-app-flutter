import 'package:cached_network_image/cached_network_image.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:ditonton/presentation/pages/home_movie_page.dart';
import 'package:flutter/material.dart';

import '../../common/constants.dart';
import '../../domain/entities/movie.dart';

class CarrouselMovieWidget extends StatelessWidget {
  final List<Movie> movies;

  const CarrouselMovieWidget({Key? key, required this.movies}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 320,
      child: Swiper(
        loop: true,
        autoplay: true,
        autoplayDelay: 5000,
        duration: 1000,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              // onTap.call(index);
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: CachedNetworkImage(
                    imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                    placeholder: (context, url) => Center(
                      child: CircularProgressIndicator(),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
                    bottom: 0,
                    child: Container(
                        padding: EdgeInsets.all(8),
                        alignment: Alignment.bottomCenter,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.redAccent),
                        child: Text('Now Playing')))
              ],
            ),
          );
        },
        itemCount: 3,
        viewportFraction: 0.62,
        scale: 0.8,
      ),
    );
  }
}
