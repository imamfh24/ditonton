part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieTopRatedInitial extends MovieTopRatedState {}

final class MovieTopRatedLoading extends MovieTopRatedState {}

final class MovieTopRatedError extends MovieTopRatedState {
  final String message;

  MovieTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieTopRatedHasData extends MovieTopRatedState {
  final List<Movie> result;

  MovieTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}
