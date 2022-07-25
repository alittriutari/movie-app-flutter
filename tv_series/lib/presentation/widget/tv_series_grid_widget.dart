import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../tv_series.dart';
import '../pages/tv_series_detail_page.dart';

class TVSeriesListGrid extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TVSeriesListGrid(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisSpacing: 8.0,
        childAspectRatio: 0.47,
        crossAxisCount: 3,
      ),
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final tv = tvSeries[index];
        return InkWell(
          onTap: () => Navigator.pushNamed(
            context,
            TvSeriesDetailPage.routeName,
            arguments: tv.id,
          ),
          child: ClipRRect(
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomCacheImage(
                  imageUrl: '$baseImageUrl${tv.posterPath}',
                  width: 100,
                  height: 180,
                ),
                Text(
                  tv.name ?? '',
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ),
          ),
        );
      },
      itemCount: tvSeries.length,
    );
  }
}
