part of 'tv_watchlist_bloc.dart';

sealed class TvWatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvFetchWatchlist extends TvWatchlistEvent {}
