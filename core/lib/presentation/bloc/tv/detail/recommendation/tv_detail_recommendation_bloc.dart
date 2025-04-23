import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_recommendation_event.dart';
part 'tv_detail_recommendation_state.dart';

class TvDetailRecommendationBloc extends Bloc<TvDetailRecommendationEvent,
    TvDetailRecommendationState> {
  final GetTvRecommendations getTvRecommendations;

  TvDetailRecommendationBloc(this.getTvRecommendations)
      : super(TvDetailRecommendationInitial()) {
    on<FetchTvDetailRecommendationEvent>(_fetchTvDetailRecommendation);
  }
  Future<void> _fetchTvDetailRecommendation(
      FetchTvDetailRecommendationEvent event,
      Emitter<TvDetailRecommendationState> emit) async {
    emit(TvDetailRecommendationLoading());

    final result = await getTvRecommendations.execute(event.tvId);

    result.fold((failure) {
      emit(TvDetailRecommendationError(failure.message));
    }, (recommendations) {
      if (recommendations.isNotEmpty) {
        emit(TvDetailRecommendationHasData(recommendations));
      } else {
        emit(TvDetailRecommendationEmpty());
      }
    });
  }
}
