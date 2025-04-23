part of 'movie_detail_recommendation_bloc.dart';

sealed class MovieDetailRecommendationEvent {
  const MovieDetailRecommendationEvent();
}

class FetchMovieDetailRecommendationEvent extends MovieDetailRecommendationEvent {
  final int movieId;

  const FetchMovieDetailRecommendationEvent(this.movieId);
}
