part of 'tv_detail_recommendation_bloc.dart';

sealed class TvDetailRecommendationEvent{
  const TvDetailRecommendationEvent();
}

class FetchTvDetailRecommendationEvent extends TvDetailRecommendationEvent {
  final int tvId;

  const FetchTvDetailRecommendationEvent(this.tvId);

}
