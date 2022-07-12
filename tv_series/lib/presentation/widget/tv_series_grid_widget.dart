import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:tv_series/domain/entities/tv_series.dart';

import '../../tv_series.dart';
import '../pages/tv_series_detail_page.dart';

class TVSeriesListGrid extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TVSeriesListGrid(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return tvSeries.isEmpty
        ? Center(
            child: Text(
            'Your watchlist is empty',
            style: kSubtitle,
          ))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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
                  TvSeriesDetailPage.ROUTE_NAME,
                  arguments: tv.id,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CustomCacheImage(
                        imageUrl: '$BASE_IMAGE_URL${tv.posterPath}',
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
