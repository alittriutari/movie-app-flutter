import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:movie_app/common/constants.dart';
import 'package:movie_app/common/utils.dart';
import 'package:movie_app/features/movies/presentation/pages/about_page.dart';
import 'package:movie_app/features/movies/presentation/pages/home_page.dart';
import 'package:movie_app/features/movies/presentation/pages/movie_detail_page.dart';
import 'package:movie_app/features/movies/presentation/pages/popular_movies_page.dart';
import 'package:movie_app/features/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_detail_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/movie_list_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/popular_movies_notifier.dart';
import 'package:movie_app/features/movies/presentation/provider/top_rated_movies_notifier.dart';
import 'package:movie_app/features/search/presentation/pages/search_page.dart';
import 'package:movie_app/features/search/presentation/provider/movie_search_notifier.dart';
import 'package:movie_app/features/search/presentation/provider/tv_series_search_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/pages/on_air_tv_series_page.dart';
import 'package:movie_app/features/tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:movie_app/features/tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:movie_app/features/tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:movie_app/features/tv_series/presentation/providers/on_air_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/popular_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/top_rated_tv_series_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_episode_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_detail_notifier.dart';
import 'package:movie_app/features/tv_series/presentation/providers/tv_series_list_notifier.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_movie_notifier.dart';
import 'package:movie_app/features/watchlist/presentation/provider/watchlist_tv_notifier.dart';
import 'package:movie_app/injection.dart' as di;
import 'package:provider/provider.dart';

void main() async {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<MovieDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularMoviesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistMovieNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesListNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<OnAirTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<PopularTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TopRatedTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvSeriesDetailNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<SearchTvSeriesNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<WatchlistTvNotifier>(),
        ),
        ChangeNotifierProvider(
          create: (_) => di.locator<TvEpisodeNotifier>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: Material(child: HomeScreen(selectedIndex: 0)),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(
                  builder: (_) => HomeScreen(
                        selectedIndex: 0,
                      ));
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case OnAirTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => OnAirTvSeriesPage());
            case PopularTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesDetailPage(
                        id: id,
                      ),
                  settings: settings);
            case SearchPage.ROUTE_NAME:
              // return CupertinoPageRoute(builder: (_) => SearchPage());
              final index = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        index: index,
                      ),
                  settings: settings);

            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
