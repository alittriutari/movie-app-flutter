import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:movie/presentation/widgets/placeholder_widget.dart';
import 'package:movie/presentation/widgets/sub_heading_widget.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/widget/carrousel_tv_series_widget.dart';

import '../../tv_series.dart';
import 'popular_tv_series_page.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  ScrollController _controller = ScrollController(initialScrollOffset: 0.0);

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(controller: _controller, slivers: [
      SliverToBoxAdapter(
        child: BlocBuilder<OnAirTvBloc, OnAirTvState>(builder: (context, state) {
          switch (state.runtimeType) {
            case OnAirTvLoading:
              return Center(
                child: PlaceholderWidget(
                  height: 400,
                  width: double.infinity,
                ),
              );
            case OnAirTvFailure:
              final _msg = (state as OnAirTvFailure).failure;
              return Center(
                key: Key('error_message'),
                child: Text(_msg.toString()),
              );
            case OnAirTvLoaded:
              final _data = (state as OnAirTvLoaded).data;
              return CarrouselTvSeriesWidget(
                tvSeries: _data,
              );
          }
          return SizedBox.shrink();
        }),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SubHeadingWidget(key: Key('show_popular_tv'), title: 'Popular', onTap: () => Navigator.pushNamed(context, PopularTvSeriesPage.ROUTE_NAME)),
              BlocBuilder<PopularTvBloc, PopularTvState>(builder: (context, state) {
                switch (state.runtimeType) {
                  case PopularTvLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case PopularTvFailure:
                    final _msg = (state as PopularTvFailure).failure;
                    return Center(
                      key: Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case PopularTvLoaded:
                    final _data = (state as PopularTvLoaded).data;
                    return TvSeriesList(_data);
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SubHeadingWidget(key: Key('show_top_rated_tv'), title: 'Top Rated', onTap: () => Navigator.pushNamed(context, TopRatedTvSeriesPage.ROUTE_NAME)),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(builder: (context, state) {
                switch (state.runtimeType) {
                  case TopRatedTvLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case TopRatedTvFailure:
                    final _msg = (state as TopRatedTvFailure).failure;
                    return Center(
                      key: Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case TopRatedTvLoaded:
                    final _data = (state as TopRatedTvLoaded).data;
                    return TvSeriesList(_data);
                }
                return SizedBox.shrink();
              }),
            ],
          ),
        ),
      ),
    ]);
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  TvSeriesList(this.tvSeries);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: Key('show_tv_detail'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesDetailPage.ROUTE_NAME, arguments: series.id);
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CustomCacheImage(
                  imageUrl: '$BASE_IMAGE_URL${series.posterPath}',
                  width: 90,
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
