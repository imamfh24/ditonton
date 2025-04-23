part of 'movie_detail_recommendation_bloc.dart';

abstract class MovieDetailRecommendationState extends Equatable {
  const MovieDetailRecommendationState();

  @override
  List<Object?> get props => [];
}

class MovieDetailRecommendationInitial extends MovieDetailRecommendationState {}

class MovieDetailRecommendationEmpty extends MovieDetailRecommendationState {}

class MovieDetailRecommendationLoading extends MovieDetailRecommendationState {}

class MovieDetailRecommendationHasData extends MovieDetailRecommendationState {
  final List<Movie> recommendations;

  const MovieDetailRecommendationHasData(this.recommendations);

  @override
  List<Object?> get props => [recommendations];
}

class MovieDetailRecommendationError extends MovieDetailRecommendationState {
  final String message;

  const MovieDetailRecommendationError(this.message);

  @override
  List<Object?> get props => [message];
}