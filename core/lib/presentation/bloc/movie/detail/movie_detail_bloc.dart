import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  // static const watchlistAddSuccessMessage = 'Added to Watchlist';
  // static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetMovieDetail getMovieDetail;
  // final GetMovieRecommendations getMovieRecommendations;
  // final GetWatchListStatus getWatchListStatus;
  // final SaveWatchlist saveWatchlist;
  // final RemoveWatchlist removeWatchlist;
  MovieDetailBloc(
    this.getMovieDetail,
    // this.getMovieRecommendations,
    // this.getWatchListStatus,
    // this.saveWatchlist,
    // this.removeWatchlist,
  ) : super(MovieDetailInitial()) {
    on<MovieDetailFetch>(_movieDetailFetch);
    // on<MovieDetailRecommendationFetch>(_movieDetailRecommendationFetch);
    // on<MovieDetailAddWatchlist>(_movieDetailAddWatchlist);
    // on<MovieDetailRemoveWatchlist>(_movieDetailRemoveWatchlist);
    // on<MovieDetailLoadStatusWatchlist>(_loadWatchlistStatus);
  }

  Future<void> _movieDetailFetch(
      MovieDetailFetch event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (detail) {
        emit(MovieDetailHasData(detail));
      },
    );
  }

  // Future<void> _movieDetailRecommendationFetch(
  //     MovieDetailRecommendationFetch event,
  //     Emitter<MovieDetailState> emit) async {
  //   emit(MovieDetailRecommendationLoading());

  //   final result = await getMovieRecommendations.execute(event.id);

  //   result.fold(
  //     (failure) => emit(MovieDetailRecommendationError(failure.message)),
  //     (recommendations) =>
  //         emit(MovieDetailRecommendationHasData(recommendations)),
  //   );
  // }

  // Future<void> _movieDetailAddWatchlist(
  //   MovieDetailAddWatchlist event,
  //   Emitter<MovieDetailState> emit,
  // ) async {
  //   emit(MovieDetailWatchlistLoading());

  //   final result = await saveWatchlist.executeMovie(event.movieDetail);

  //   await result.fold(
  //     (failure) async {
  //       emit(MovieDetailWatchlistMessage(failure.message));
  //     },
  //     (successMessage) async {
  //       emit(MovieDetailWatchlistMessage(successMessage));
  //     },
  //   );

  //   add(MovieDetailLoadStatusWatchlist(event.movieDetail.id));
  // }

  // Future<void> _movieDetailRemoveWatchlist(
  //   MovieDetailRemoveWatchlist event,
  //   Emitter<MovieDetailState> emit,
  // ) async {
  //   emit(MovieDetailLoading());

  //   final result = await saveWatchlist.executeMovie(event.movieDetail);

  //   await result.fold(
  //     (failure) async {
  //       emit(MovieDetailWatchlistMessage(failure.message));
  //     },
  //     (successMessage) async {
  //       emit(MovieDetailWatchlistMessage(successMessage));
  //     },
  //   );
  //   add(MovieDetailLoadStatusWatchlist(event.movieDetail.id));
  // }

  // Future<void> _loadWatchlistStatus(MovieDetailLoadStatusWatchlist event,
  //     Emitter<MovieDetailState> emit) async {
  //   final result = await getWatchListStatus.executeMovie(event.id);
  //   emit(MovieDetailIsAddToWatchlist(isAddedToWatchlist: result));
  // }
}
