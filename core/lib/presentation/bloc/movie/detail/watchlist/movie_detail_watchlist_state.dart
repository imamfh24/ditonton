import 'package:equatable/equatable.dart';

class MovieDetailWatchlistState extends Equatable {
  final bool isAddedToWatchlist;
  final String message;

  const MovieDetailWatchlistState({
    required this.isAddedToWatchlist,
    required this.message,
  });

  factory MovieDetailWatchlistState.initial() {
    return const MovieDetailWatchlistState(
      isAddedToWatchlist: false,
      message: '',
    );
  }

  @override
  List<Object> get props => [isAddedToWatchlist, message];

  MovieDetailWatchlistState copyWith({
    bool? isAddedToWatchlist,
    String? message,
  }) {
    return MovieDetailWatchlistState(
      isAddedToWatchlist: isAddedToWatchlist ?? this.isAddedToWatchlist,
      message: message ?? this.message,
    );
  }
}
