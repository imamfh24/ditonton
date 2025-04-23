part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistState extends Equatable {
  const MovieWatchlistState();

  @override
  List<Object?> get props => [];
}

final class MovieWatchlistInitial extends MovieWatchlistState {}

final class MovieWatchlistLoading extends MovieWatchlistState {}

final class MovieWatchlistError extends MovieWatchlistState {
  final String message;

  const MovieWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class MovieWatchlistHasData extends MovieWatchlistState {
  final List<Movie> result;

  const MovieWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
