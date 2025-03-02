part of 'tv_detail_bloc.dart';

sealed class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailWatchlistLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [];
}

final class TvDetailHasData extends TvDetailState {
  final TvDetail result;

  TvDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}

final class TvDetailRecommendationLoading extends TvDetailState {}

final class TvDetailRecommendationError extends TvDetailState {
  final String message;

  TvDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [];
}

final class TvDetailRecommendationHasData extends TvDetailState {
  final List<Tv> result;

  TvDetailRecommendationHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class TvDetailMessage {
  final String message;

  const TvDetailMessage({this.message = ''});
}

final class TvDetailWatchlistMessage extends TvDetailState {
  final String message;

  TvDetailWatchlistMessage(this.message);

  @override
  List<Object?> get props => [];
}

class TvDetailIsAddToWatchlist extends TvDetailState {
  final bool isAddedToWatchlist;

  TvDetailIsAddToWatchlist({this.isAddedToWatchlist = false});

  @override
  List<Object?> get props => [isAddedToWatchlist];
}
