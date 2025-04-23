part of 'movie_detail_recommendation_bloc.dart';

sealed class MovieDetailRecommendationEvent extends Equatable {
  const MovieDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchMovieDetailRecommendationEvent extends MovieDetailRecommendationEvent {
  final int movieId;

  const FetchMovieDetailRecommendationEvent(this.movieId);

  @override
  List<Object> get props => [movieId];
}
