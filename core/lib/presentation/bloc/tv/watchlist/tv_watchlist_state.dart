part of 'tv_watchlist_bloc.dart';

sealed class TvWatchlistState extends Equatable {
  const TvWatchlistState();

  @override
  List<Object?> get props => [];
}

final class TvWatchlistInitial extends TvWatchlistState {}

final class TvWatchlistLoading extends TvWatchlistState {}

final class TvWatchlistError extends TvWatchlistState {
  final String message;

  const TvWatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class TvWatchlistHasData extends TvWatchlistState {
  final List<Tv> result;

  const TvWatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
