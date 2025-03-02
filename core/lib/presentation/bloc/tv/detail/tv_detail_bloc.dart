import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_detail_event.dart';
part 'tv_detail_state.dart';

class TvDetailBloc extends Bloc<TvDetailEvent, TvDetailState> {
  static const watchlistAddSuccessMessage = 'Added to TV Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from TV Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  TvDetailBloc(this.getTvDetail, this.getTvRecommendations,
      this.getWatchListStatus, this.saveWatchlist, this.removeWatchlist)
      : super(TvDetailInitial()) {
    on<TvDetailFetch>(_tvDetailFetch);
    on<TvDetailRecommendationFetch>(_tvDetailRecommendationFetch);
    on<TvDetailAddWatchlist>(_tvDetailAddWatchlist);
    on<TvDetailRemoveWatchlist>(_tvDetailRemoveWatchlist);
    on<TvDetailLoadStatusWatchlist>(_loadWatchlistStatus);
  }

  Future<void> _tvDetailFetch(
      TvDetailFetch event, Emitter<TvDetailState> emit) async {
    emit(TvDetailLoading());

    final result = await getTvDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(TvDetailError(failure.message));
      },
      (detail) {
        emit(TvDetailHasData(detail));
        add(TvDetailRecommendationFetch(event.id));
      },
    );
  }

  Future<void> _tvDetailRecommendationFetch(
      TvDetailRecommendationFetch event, Emitter<TvDetailState> emit) async {
    emit(TvDetailRecommendationLoading());

    final result = await getTvRecommendations.execute(event.id);

    result.fold(
      (failure) => emit(TvDetailRecommendationError(failure.message)),
      (recommendations) => emit(TvDetailRecommendationHasData(recommendations)),
    );
  }

  Future<void> _tvDetailAddWatchlist(
    TvDetailAddWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(TvDetailWatchlistLoading());

    final result = await saveWatchlist.executeTv(event.tvDetail);

    await result.fold(
      (failure) async {
        emit(TvDetailWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(TvDetailWatchlistMessage(successMessage));
      },
    );

    add(TvDetailLoadStatusWatchlist(event.tvDetail.id));
  }

  Future<void> _tvDetailRemoveWatchlist(
    TvDetailRemoveWatchlist event,
    Emitter<TvDetailState> emit,
  ) async {
    emit(TvDetailLoading());

    final result = await saveWatchlist.executeTv(event.tvDetail);

    await result.fold(
      (failure) async {
        emit(TvDetailWatchlistMessage(failure.message));
      },
      (successMessage) async {
        emit(TvDetailWatchlistMessage(successMessage));
      },
    );
    add(TvDetailLoadStatusWatchlist(event.tvDetail.id));
  }

  Future<void> _loadWatchlistStatus(
      TvDetailLoadStatusWatchlist event, Emitter<TvDetailState> emit) async {
    final result = await getWatchListStatus.executeTv(event.id);
    emit(TvDetailIsAddToWatchlist(isAddedToWatchlist: result));
  }
}
