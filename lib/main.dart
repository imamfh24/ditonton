import 'package:about/about.dart';
import 'package:core/core.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv/detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tv/airing_today/tv_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/popular/tv_popular_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated/tv_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist/tv_watchlist_bloc.dart';
import 'package:core/presentation/pages/home_movie_page.dart';
import 'package:core/presentation/pages/home_tv_page.dart';
import 'package:core/presentation/pages/movie_detail_page.dart';
import 'package:core/presentation/pages/popular_movies_page.dart';
import 'package:core/presentation/pages/top_rated_movies_page.dart';
import 'package:core/presentation/pages/tv_airing_today_page.dart';
import 'package:core/presentation/pages/tv_detail_page.dart';
import 'package:core/presentation/pages/tv_popular_page.dart';
import 'package:core/presentation/pages/tv_top_rated_page.dart';
import 'package:core/presentation/pages/watchlist_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:search/search.dart';

import 'package:ditonton/firebase_options.dart';
import 'package:ditonton/injection.dart' as di;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) => di.locator<MovieListNowPlayingBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieListTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieDetailWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MoviePopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvAiringTodayBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvDetailWatchlistCubit>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvPopularBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvWatchlistBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<MovieSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<TvSearchBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Ditonton',
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
          drawerTheme: kDrawerTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case popularMovieRoute:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case topRatedRoute:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case movieDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case searchMovieRoute:
              return CupertinoPageRoute(builder: (_) => SearchMoviePage());
            case searchTvRoute:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
            case watchlistRoute:
              return MaterialPageRoute(builder: (_) => WatchlistPage());
            case aboutRoute:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case tvHome:
              return MaterialPageRoute(builder: (_) => HomeTvPage());
            case tvAiringTodayRoute:
              return MaterialPageRoute(builder: (_) => TvAiringTodayPage());
            case tvDetailRoute:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TvDetailPage(id: id),
                settings: settings,
              );
            case tvPopularRoute:
              return CupertinoPageRoute(builder: (_) => TvPopularPage());
            case tvTopRatedRoute:
              return CupertinoPageRoute(builder: (_) => TvTopRatedPage());
            case tvSearchRoute:
              return CupertinoPageRoute(builder: (_) => SearchTvPage());
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
