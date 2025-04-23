import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_list_event.dart';
part 'movie_list_state.dart';

class MovieListNowPlayingBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  MovieListNowPlayingBloc(this.getNowPlayingMovies)
      : super(MovieListInitial()) {
    on<MovieListFetchNowPlayingMovies>(_fetchNowPlayingMovies);
  }

  Future<void> _fetchNowPlayingMovies(MovieListFetchNowPlayingMovies event,
      Emitter<MovieListState> emit) async {
    emit(MovieListLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(MovieListError(failure.message)),
      (data) => emit(MovieListHasData(data)),
    );
  }
}

class MovieListPopularBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetPopularMovies getPopularMovies;
  MovieListPopularBloc(this.getPopularMovies) : super(MovieListInitial()) {
    on<MovieListFetchPopularMovies>(_fetchPopularMovies);
  }

  Future<void> _fetchPopularMovies(
      MovieListFetchPopularMovies event, Emitter<MovieListState> emit) async {
    emit(MovieListLoading());
    final result = await getPopularMovies.execute();
    result.fold(
      (failure) => emit(MovieListError(failure.message)),
      (data) => emit(MovieListHasData(data)),
    );
  }
}

class MovieListTopRatedBloc extends Bloc<MovieListEvent, MovieListState> {
  final GetTopRatedMovies getTopRatedMovies;
  MovieListTopRatedBloc(this.getTopRatedMovies) : super(MovieListInitial()) {
    on<MovieListFetchTopRatedMovies>(_fetchTopRatedMovies);
  }

  Future<void> _fetchTopRatedMovies(
      MovieListFetchTopRatedMovies event, Emitter<MovieListState> emit) async {
    emit(MovieListLoading());
    final result = await getTopRatedMovies.execute();
    result.fold(
      (failure) => emit(MovieListError(failure.message)),
      (data) => emit(MovieListHasData(data)),
    );
  }
}
