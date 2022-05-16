import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

class HomeRobot {
  final WidgetTester tester;

  HomeRobot(this.tester);

  Future<void> clickNavigationDrawerIcon() async {
    final drawerIconFinder = find.byKey(Key('drawer_icon'));

    await tester.ensureVisible(drawerIconFinder);
    await tester.tap(drawerIconFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickSearchIcon() async {
    final searchIconFinder = find.byKey(Key('search_icon'));

    await tester.ensureVisible(searchIconFinder);
    await tester.tap(searchIconFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickMovieMenu() async {
    final movieMenuFinder = find.byKey(const Key('movie_menu'));

    await tester.ensureVisible(movieMenuFinder);
    await tester.tap(movieMenuFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickTvMenu() async {
    final tvMenuFinder = find.byKey(const Key('tv_menu'));

    await tester.ensureVisible(tvMenuFinder);
    await tester.tap(tvMenuFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickWachlist() async {
    final watchlistMenuFinder = find.byKey(const Key('watchlist_menu'));

    await tester.ensureVisible(watchlistMenuFinder);
    await tester.tap(watchlistMenuFinder);

    await tester.pumpAndSettle();
  }

  Future<void> clickShowPopularMovie() async {
    final showPopularMovie = find.byKey(const Key('show_popular_movie'));

    await tester.ensureVisible(showPopularMovie);
    await tester.tap(showPopularMovie);

    await tester.pumpAndSettle();
  }

  Future<void> clickShowTopRatedMovie() async {
    final showTopRatedMovie = find.byKey(const Key('show_top_rated_movie'));

    await tester.ensureVisible(showTopRatedMovie);
    await tester.tap(showTopRatedMovie);

    await tester.pumpAndSettle();
  }

  Future<void> clickShowMovieDetail() async {
    final showMovieDetail = find.byKey(const Key('show_movie_detail'));

    await tester.ensureVisible(showMovieDetail);
    await tester.tap(showMovieDetail);

    await tester.pumpAndSettle();
  }

  Future<void> clickShowPopularTv() async {
    final showPopularTv = find.byKey(const Key('show_popular_tv'));

    await tester.ensureVisible(showPopularTv);
    await tester.tap(showPopularTv);

    await tester.pumpAndSettle();
  }

  Future<void> clickShowTvDetail() async {
    final showTvDetail = find.byKey(const Key('show_tv_detail'));

    await tester.ensureVisible(showTvDetail);
    await tester.tap(showTvDetail);

    await tester.pumpAndSettle();
  }
}
