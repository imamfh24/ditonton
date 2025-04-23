part of 'movie_watchlist_bloc.dart';

sealed class MovieWatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieFetchWatchlist extends MovieWatchlistEvent {}
