part of 'tv_detail_recommendation_bloc.dart';

sealed class TvDetailRecommendationEvent extends Equatable {
  const TvDetailRecommendationEvent();

  @override
  List<Object> get props => [];
}

class FetchTvDetailRecommendationEvent extends TvDetailRecommendationEvent {
  final int tvId;

  const FetchTvDetailRecommendationEvent(this.tvId);

  @override
  List<Object> get props => [tvId];
}
