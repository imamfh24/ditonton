part of 'movie_now_playing_bloc.dart';

sealed class MovieNowPlayingState extends Equatable {
  const MovieNowPlayingState();
  @override
  List<Object?> get props => [];
}

final class MovieNowPlayingInitial extends MovieNowPlayingState {}

final class MovieNowPlayingLoading extends MovieNowPlayingState {}

final class MovieNowPlayingError extends MovieNowPlayingState {
  final String message;

  const MovieNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

final class MovieNowPlayingHasData extends MovieNowPlayingState {
  final List<Movie> result;

  const MovieNowPlayingHasData(this.result);

  @override
  List<Object> get props => [result];
}

