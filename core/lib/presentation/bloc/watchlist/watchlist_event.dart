part of 'watchlist_bloc.dart';

sealed class WatchlistEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchWatchlist extends WatchlistEvent {
  final WatchType watchType;
  FetchWatchlist(
    this.watchType,
  );

  @override
  List<Object?> get props => [watchType];
}
