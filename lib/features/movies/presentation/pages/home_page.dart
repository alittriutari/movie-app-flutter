import 'package:ditonton/common/constants.dart';
import 'package:ditonton/features/movies/presentation/pages/home_movie_page.dart';
import 'package:ditonton/features/movies/presentation/pages/home_tv_series_page.dart';
import 'package:ditonton/features/tv_series/presentation/pages/home_tv_series_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          title: Row(
            children: [
              Text('Movie App'),
              SizedBox(
                width: 5,
              ),
              Icon(Icons.camera_outdoor)
            ],
          ),
          bottom: TabBar(
              isScrollable: true,
              indicatorColor: kMikadoYellow,
              indicator: BoxDecoration(borderRadius: BorderRadius.circular(50), color: Color(0xffFCA311)),
              tabs: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Movies'),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Tv Series'),
                ),
                Container(
                  padding: EdgeInsets.all(8),
                  child: Text('Watch List'),
                ),
              ]),
        ),
        body: TabBarView(children: [HomeMoviePage(), HomeTvSeriesPage(), Text('hahahah')]),
      ),
    );
  }
}
