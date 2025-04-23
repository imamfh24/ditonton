import 'package:equatable/equatable.dart';

class TvDetailWatchlistState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const TvDetailWatchlistState({
    required this.isAddedToWatchlist,
    required this.message,
  });

  factory TvDetailWatchlistState.initial() {
    return const TvDetailWatchlistState(
      isAddedToWatchlist: false,
      message: '',
    );
  }

  @override
  List<Object> get props => [isAddedToWatchlist, message];

  TvDetailWatchlistState copyWith({
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return TvDetailWatchlistState(
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
    );
  }
}
