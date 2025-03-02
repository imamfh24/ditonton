part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}
final class MovieDetailWatchlistLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object?> get props => [];
}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}

final class MovieDetailRecommendationLoading extends MovieDetailState {}

final class MovieDetailRecommendationError extends MovieDetailState {
  final String message;

  MovieDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [];
}

final class MovieDetailRecommendationHasData extends MovieDetailState {
  final List<Movie> result;

  MovieDetailRecommendationHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class MovieDetailMessage {
  final String message;

  const MovieDetailMessage({this.message = ''});
}

final class MovieDetailWatchlistMessage extends MovieDetailState {
  final String message;

  MovieDetailWatchlistMessage(this.message);

  @override
  List<Object?> get props => [];
}

class MovieDetailIsAddToWatchlist extends MovieDetailState {
  final bool isAddedToWatchlist;

  MovieDetailIsAddToWatchlist({this.isAddedToWatchlist = false});

  @override
  List<Object?> get props => [isAddedToWatchlist];
}
