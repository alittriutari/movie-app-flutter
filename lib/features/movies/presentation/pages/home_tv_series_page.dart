import 'package:ditonton/common/constants.dart';
import 'package:ditonton/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:flutter/material.dart';

import '../widgets/sub_heading_widget.dart';

class HomeTvSeriesPage extends StatefulWidget {
  const HomeTvSeriesPage({Key? key}) : super(key: key);

  @override
  State<HomeTvSeriesPage> createState() => _HomeTvSeriesPageState();
}

class _HomeTvSeriesPageState extends State<HomeTvSeriesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(8),
        child: SingleChildScrollView(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                'Now Playing',
                style: kHeading6,
              ),
            ),
            SubHeadingWidget(title: 'Popular', onTap: () => Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME)),
            SubHeadingWidget(title: 'Top Rated', onTap: () => Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME)),
          ],
        )),
      ),
    );
  }
}
