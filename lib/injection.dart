import 'package:core/data/datasources/db/database_helper.dart';
import 'package:core/data/datasources/movies/movie_local_data_source.dart';
import 'package:core/data/datasources/movies/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv/tv_local_data_source.dart';
import 'package:core/data/datasources/tv/tv_remote_data_source.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/domain/usecases/movies/get_movie_status_watchlist.dart';
import 'package:core/domain/usecases/movies/get_movie_watchlist.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/domain/usecases/movies/remove_movie_from_watchlist.dart';
import 'package:core/domain/usecases/movies/save_movie_to_watchlist.dart';
import 'package:core/domain/usecases/tv/get_tv_airing_today.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_popular.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/domain/usecases/tv/get_tv_top_rated.dart';
import 'package:core/domain/usecases/tv/get_tv_watchlist.dart';
import 'package:core/domain/usecases/tv/get_tv_status_watchlist.dart';
import 'package:core/domain/usecases/tv/remove_tv_from_watchlist.dart';
import 'package:core/domain/usecases/tv/save_tv_to_watchlist.dart';
import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:core/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/presentation/bloc/tv/airing_today/tv_airing_today_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv/popular/tv_popular_bloc.dart';
import 'package:core/presentation/bloc/tv/top_rated/tv_top_rated_bloc.dart';
import 'package:core/presentation/bloc/tv/watchlist/tv_watchlist_bloc.dart';
import 'package:core/utils/ssl_pinning.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';
import 'package:search/search.dart';

final locator = GetIt.instance;

Future<void> init() async {
  // Http SSL Pinning
  final secureClient = await SslPinningHttpClient.getClient();
  locator.registerLazySingleton<http.Client>(() => secureClient);

  // provider
  locator.registerFactory(
    () => MovieListNowPlayingBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieListTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => MovieDetailRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieDetailWatchlistCubit(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => MoviePopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieTopRatedBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieWatchlistBloc(
      getWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvWatchlistBloc(
      getWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvDetailRecommendationBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => TvDetailWatchlistCubit(
      locator(),
      locator(),
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvAiringTodayBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvTopRatedBloc(
      locator(),
    ),
  );

  locator.registerFactory(
    () => TvPopularBloc(
      locator(),
    ),
  );
  locator.registerFactory(
    () => MovieSearchBloc(locator()),
  );
  locator.registerFactory(
    () => TvSearchBloc(locator()),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => GetMovieWatchlist(locator()));
  locator.registerLazySingleton(() => GetMovieStatusWatchlist(locator()));
  locator.registerLazySingleton(() => SaveMovieToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveMovieFromWatchlist(locator()));
  
  locator.registerLazySingleton(() => GetTvAiringToday(locator()));
  locator.registerLazySingleton(() => GetTvDetail(locator()));
  locator.registerLazySingleton(() => GetTvRecommendations(locator()));
  locator.registerLazySingleton(() => GetTvTopRated(locator()));
  locator.registerLazySingleton(() => GetTvPopular(locator()));
  locator.registerLazySingleton(() => GetTvWatchlist(locator()));
  locator.registerLazySingleton(() => GetTvStatusWatchlist(locator()));
  locator.registerLazySingleton(() => SaveTvToWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTvFromWatchlist(locator()));
  
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => SearchTv(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );
  locator.registerLazySingleton<TvRepository>(
    () => TvRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));
  locator.registerLazySingleton<TvRemoteDataSource>(
      () => TvRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvLocalDataSource>(
      () => TvLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());
}
