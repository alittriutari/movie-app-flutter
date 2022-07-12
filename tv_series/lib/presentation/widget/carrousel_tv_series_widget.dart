import 'package:card_swiper/card_swiper.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/pages/on_air_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';

class CarrouselTvSeriesWidget extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const CarrouselTvSeriesWidget({Key? key, required this.tvSeries}) : super(key: key);

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
                TvSeriesDetailPage.routeName,
                arguments: tv.id,
              );
            },
            child: Stack(alignment: Alignment.center, children: [
              SizedBox(
                height: 500,
                child: CustomCacheImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
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
                bottom: 110,
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
                bottom: 60,
                child: Container(
                    width: 100,
                    padding: const EdgeInsets.all(8),
                    alignment: Alignment.bottomCenter,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: Colors.redAccent),
                    child: const Text('On Airing')),
              ),
              Positioned(
                bottom: 20,
                child: InkWell(
                  onTap: () => Navigator.pushNamed(context, OnAirTvSeriesPage.routeName),
                  child: const Text(
                    'See more on airing ',
                    textAlign: TextAlign.center,
                    style: TextStyle(decoration: TextDecoration.underline, fontWeight: FontWeight.bold),
                  ),
                ),
              )
            ]),
          );
        },
        itemCount: 10,
      ),
    );
  }
}
