part of 'movie_list_bloc.dart';

sealed class MovieListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieListFetchNowPlayingMovies extends MovieListEvent {}
final class MovieListFetchPopularMovies extends MovieListEvent {}
final class MovieListFetchTopRatedMovies extends MovieListEvent {}
