import 'package:core/core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie/presentation/bloc/movie_detail_bloc.dart';
import 'package:movie/presentation/bloc/now_playing_movie_bloc.dart';
import 'package:movie/presentation/bloc/popular_movie_bloc.dart';
import 'package:movie/presentation/bloc/recommendation_movie_bloc.dart';
import 'package:movie/presentation/bloc/top_rated_movie_bloc.dart';
import 'package:movie/presentation/pages/about_page.dart';
import 'package:movie/presentation/pages/home_page.dart';
import 'package:movie/presentation/pages/movie_detail_page.dart';
import 'package:movie/presentation/pages/popular_movies_page.dart';
import 'package:movie/presentation/pages/top_rated_movies_page.dart';
import 'package:movie_app/injection.dart' as di;
import 'package:provider/provider.dart';
import 'package:search/presentation/bloc/movie_search_bloc.dart';
import 'package:search/presentation/bloc/tv_search_bloc.dart';
import 'package:search/presentation/pages/search_page.dart';
import 'package:tv_series/presentation/bloc/episode_bloc.dart';
import 'package:tv_series/presentation/bloc/on_air_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/popular_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/recommendation_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/top_rated_tv_bloc.dart';
import 'package:tv_series/presentation/bloc/tv_detail_bloc.dart';
import 'package:tv_series/presentation/pages/on_air_tv_series_page.dart';
import 'package:tv_series/presentation/pages/popular_tv_series_page.dart';
import 'package:tv_series/presentation/pages/top_rated_tv_series_page.dart';
import 'package:tv_series/presentation/pages/tv_series_detail_page.dart';
import 'package:watchlist/presentation/bloc/watchlist_movie_bloc.dart';
import 'package:watchlist/presentation/bloc/watchlist_tv_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  await di.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider(create: (_) => di.locator<PopularMovieBloc>()..add(GetPopularMovieEvent())),
        BlocProvider(create: (_) => di.locator<TopRatedMovieBloc>()..add(GetTopRatedMovieListEvent())),
        BlocProvider(create: (_) => di.locator<NowPlayingMovieBloc>()..add(GetNowPlayingMovieEvent())),
        BlocProvider(create: (_) => di.locator<MovieDetailBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationMovieBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistMovieBloc>()),
        BlocProvider(create: (_) => di.locator<PopularTvBloc>()..add(GetPopularTvListEvent())),
        BlocProvider(create: (_) => di.locator<TopRatedTvBloc>()..add(GetTopRatedTvListEvent())),
        BlocProvider(create: (_) => di.locator<OnAirTvBloc>()..add(GetOnAirTvListEvent())),
        BlocProvider(create: (_) => di.locator<TvDetailBloc>()),
        BlocProvider(create: (_) => di.locator<RecommendationTvBloc>()),
        BlocProvider(create: (_) => di.locator<WatchlistTvBloc>()),
        BlocProvider(create: (_) => di.locator<EpisodeBloc>()),
        BlocProvider(create: (_) => di.locator<MovieSearchBloc>()),
        BlocProvider(create: (_) => di.locator<TvSearchBloc>()),
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
            case PopularMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.routeName:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case OnAirTvSeriesPage.routeName:
              return CupertinoPageRoute(builder: (_) => OnAirTvSeriesPage());
            case PopularTvSeriesPage.routeName:
              return CupertinoPageRoute(builder: (_) => PopularTvSeriesPage());
            case TopRatedTvSeriesPage.routeName:
              return CupertinoPageRoute(builder: (_) => TopRatedTvSeriesPage());
            case TvSeriesDetailPage.routeName:
              final id = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => TvSeriesDetailPage(
                        id: id,
                      ),
                  settings: settings);
            case SearchPage.routeName:
              // return CupertinoPageRoute(builder: (_) => SearchPage());
              final index = settings.arguments as int;
              return CupertinoPageRoute(
                  builder: (_) => SearchPage(
                        index: index,
                      ),
                  settings: settings);

            case AboutPage.routeName:
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
