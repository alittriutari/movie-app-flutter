import 'package:card_swiper/card_swiper.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';

import '../../domain/entities/movie.dart';
import 'custom_cache_image.dart';

class CarrouselMovieWidget extends StatelessWidget {
  final List<Movie> movies;

  const CarrouselMovieWidget({
    Key? key,
    required this.movies,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 500,
      child: Swiper(
        loop: true,
        autoplay: true,
        autoplayDelay: 5000,
        duration: 1000,
        itemBuilder: (BuildContext context, int index) {
          final movie = movies[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                MovieDetailPage.routeName,
                arguments: movie.id,
              );
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                  height: 500,
                  child: CustomCacheImage(
                    imageUrl: '$baseImageUrl${movie.posterPath}',
                    height: 500,
                    boxFit: BoxFit.cover,
                    width: double.infinity,
                  )),
              Container(
                height: 500,
                decoration: const BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.black, Colors.transparent],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                  ),
                ),
              ),
              Positioned(
                bottom: 90,
                child: SizedBox(
                    width: 250,
                    child: Text(
                      movie.title ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
              ),
              Positioned(
                bottom: 40,
                child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.redAccent),
                    child: const Text('Now Playing')),
              )
            ]),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
