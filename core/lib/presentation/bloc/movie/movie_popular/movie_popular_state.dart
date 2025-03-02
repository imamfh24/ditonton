part of 'movie_popular_bloc.dart';

sealed class MoviePopularState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MoviePopularInitial extends MoviePopularState {}

final class MoviePopularLoading extends MoviePopularState {}

final class MoviePopularError extends MoviePopularState {
  final String message;

  MoviePopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class MoviePopularHasData extends MoviePopularState {
  final List<Movie> result;

  MoviePopularHasData(this.result);

  @override
  List<Object> get props => [result];
}
