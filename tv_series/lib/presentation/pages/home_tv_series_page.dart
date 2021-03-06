import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/widgets/custom_cache_image.dart';
import 'package:movie/presentation/widgets/placeholder_widget.dart';
import 'package:movie/presentation/widgets/sub_heading_widget.dart';
import 'package:tv_series/domain/entities/tv_series.dart';
import 'package:tv_series/presentation/bloc/on_air_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:tv_series/presentation/widget/carrousel_tv_series_widget.dart';

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
        child:
            BlocBuilder<OnAirTvBloc, OnAirTvState>(builder: (context, state) {
          switch (state.runtimeType) {
            case OnAirTvLoading:
              return const Center(
                child: PlaceholderWidget(
                  height: 400,
                  width: double.infinity,
                ),
              );
            case OnAirTvFailure:
              final _msg = (state as OnAirTvFailure).failure;
              return Center(
                key: const Key('error_message'),
                child: Text(_msg.toString()),
              );
            case OnAirTvLoaded:
              final _data = (state as OnAirTvLoaded).data;
              return CarrouselTvSeriesWidget(
                tvSeries: _data,
              );
          }
          return const SizedBox.shrink();
        }),
      ),
      SliverToBoxAdapter(
        child: Container(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              SubHeadingWidget(
                  key: const Key('show_popular_tv'),
                  title: 'Popular',
                  onTap: () => Navigator.pushNamed(
                      context, PopularTvSeriesPage.routeName)),
              BlocBuilder<PopularTvBloc, PopularTvState>(
                  builder: (context, state) {
                switch (state.runtimeType) {
                  case PopularTvLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => const PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case PopularTvFailure:
                    final _msg = (state as PopularTvFailure).failure;
                    return Center(
                      key: const Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case PopularTvLoaded:
                    final _data = (state as PopularTvLoaded).data;
                    return TvSeriesList(_data);
                }
                return const SizedBox.shrink();
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
              SubHeadingWidget(
                  key: const Key('show_top_rated_tv'),
                  title: 'Top Rated',
                  onTap: () => Navigator.pushNamed(
                      context, TopRatedTvSeriesPage.routeName)),
              BlocBuilder<TopRatedTvBloc, TopRatedTvState>(
                  builder: (context, state) {
                switch (state.runtimeType) {
                  case TopRatedTvLoading:
                    return Row(
                      children: List.generate(
                          3,
                          (index) => const PlaceholderWidget(
                                height: 150,
                                width: 90,
                              )),
                    );
                  case TopRatedTvFailure:
                    final _msg = (state as TopRatedTvFailure).failure;
                    return Center(
                      key: const Key('error_message'),
                      child: Text(_msg.toString()),
                    );
                  case TopRatedTvLoaded:
                    final _data = (state as TopRatedTvLoaded).data;
                    return TvSeriesList(_data);
                }
                return const SizedBox.shrink();
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

  const TvSeriesList(this.tvSeries, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final series = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: const Key('show_tv_detail'),
              onTap: () {
                Navigator.pushNamed(context, TvSeriesDetailPage.routeName,
                    arguments: series.id);
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CustomCacheImage(
                  imageUrl: '$baseImageUrl${series.posterPath}',
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
