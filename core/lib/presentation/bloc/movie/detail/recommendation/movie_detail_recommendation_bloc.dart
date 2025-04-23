import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_recommendation_event.dart';
part 'movie_detail_recommendation_state.dart';

class MovieDetailRecommendationBloc extends Bloc<MovieDetailRecommendationEvent,
    MovieDetailRecommendationState> {
  final GetMovieRecommendations getMovieRecommendations;

  MovieDetailRecommendationBloc(this.getMovieRecommendations)
      : super(MovieDetailRecommendationInitial()) {
    on<FetchMovieDetailRecommendationEvent>(_fetchMovieDetailRecommendation);
  }
  Future<void> _fetchMovieDetailRecommendation(
      FetchMovieDetailRecommendationEvent event,
      Emitter<MovieDetailRecommendationState> emit) async {
    emit(MovieDetailRecommendationLoading());

    final result = await getMovieRecommendations.execute(event.movieId);

    result.fold((failure) {
      emit(MovieDetailRecommendationError(failure.message));
    }, (recommendations) {
      if (recommendations.isNotEmpty) {
        emit(MovieDetailRecommendationHasData(recommendations));
      } else {
        emit(MovieDetailRecommendationEmpty());
      }
    });
  }
}
