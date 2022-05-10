import 'package:card_swiper/card_swiper.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/features/movies/presentation/widgets/custom_cache_image.dart';
import 'package:movie_app/features/tv_series/domain/entities/tv_series.dart';
import 'package:movie_app/features/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:flutter/material.dart';

class CarrouselTvSeriesWidget extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const CarrouselTvSeriesWidget({Key? key, required this.tvSeries})
      : super(key: key);

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
          final tv = tvSeries[index];
          return GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                TvSeriesDetailPage.ROUTE_NAME,
                arguments: tv.id,
              );
            },
            child: Stack(alignment: Alignment.center, children: [
              Container(
                height: 500,
                child: CustomCacheImage(
                  imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
                  boxFit: BoxFit.cover,
                  height: 500,
                  width: double.infinity,
                ),
              ),
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
                      tv.name ?? '',
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
                    padding: EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.redAccent),
                    child: Text('On Airing')),
              )
            ]),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
