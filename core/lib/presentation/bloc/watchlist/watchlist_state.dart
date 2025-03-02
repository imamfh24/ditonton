part of 'watchlist_bloc.dart';

sealed class WatchlistState extends Equatable {
  const WatchlistState();

  @override
  List<Object?> get props => [];
}

final class WatchlistInitial extends WatchlistState {}

final class WatchlistLoading extends WatchlistState {}

final class WatchlistError extends WatchlistState {
  final String message;

  const WatchlistError(this.message);

  @override
  List<Object> get props => [message];
}

class WatchlistHasData<T> extends WatchlistState {
  final List<T> result;

  const WatchlistHasData(this.result);

  @override
  List<Object> get props => [result];
}
