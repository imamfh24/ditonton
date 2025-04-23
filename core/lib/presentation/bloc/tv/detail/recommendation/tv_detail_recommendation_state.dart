part of 'tv_detail_recommendation_bloc.dart';

abstract class TvDetailRecommendationState extends Equatable {
  const TvDetailRecommendationState();

  @override
  List<Object?> get props => [];
}

class TvDetailRecommendationInitial extends TvDetailRecommendationState {}

class TvDetailRecommendationEmpty extends TvDetailRecommendationState {}

class TvDetailRecommendationLoading extends TvDetailRecommendationState {}

class TvDetailRecommendationHasData extends TvDetailRecommendationState {
  final List<Tv> recommendations;

  const TvDetailRecommendationHasData(this.recommendations);

  @override
  List<Object?> get props => [recommendations];
}

class TvDetailRecommendationError extends TvDetailRecommendationState {
  final String message;

  const TvDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}