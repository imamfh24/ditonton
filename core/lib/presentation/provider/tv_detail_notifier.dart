import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/entities/tv_detail.dart';
import '../../domain/usecases/get_tv_recommendations.dart';
import '../../domain/usecases/get_watchlist_status.dart';
import '../../domain/usecases/remove_watchlist.dart';
import '../../domain/usecases/save_watchlist.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_detail.dart';

class TvDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to TV Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from TV Watchlist';

  final GetTvDetail getTvDetail;
  final GetTvRecommendations getTvRecommendations;
  final GetWatchListStatus getWatchListStatus;
  final SaveWatchlist saveWatchlist;
  final RemoveWatchlist removeWatchlist;
  TvDetailNotifier({
    required this.getTvDetail,
    required this.getTvRecommendations,
    required this.getWatchListStatus,
    required this.saveWatchlist,
    required this.removeWatchlist,
  });

  TvDetail? _tvDetail;
  TvDetail? get tvDetail => _tvDetail;

  RequestState _tvDetailState = RequestState.empty;
  RequestState get tvDetailState => _tvDetailState;

  List<Tv> _tvRecommendation = [];
  List<Tv> get tvRecommendation => _tvRecommendation;

  RequestState _tvRecommendationState = RequestState.empty;
  RequestState get tvRecommendationState => _tvRecommendationState;

  bool _isAddedtoWatchlist = false;
  bool get isAddedToWatchlist => _isAddedtoWatchlist;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvDetail(int id) async {
    _tvDetailState = RequestState.loading;
    notifyListeners();
    final detailResult = await getTvDetail.execute(id);
    final recommendationResult = await getTvRecommendations.execute(id);

    detailResult.fold(
      (failure) {
        _tvDetailState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (value) async {
        _tvDetailState = RequestState.loaded;
        _tvDetail = value;
        notifyListeners();
        recommendationResult.fold(
          (failure) {
            _tvRecommendationState = RequestState.error;
            _message = failure.message;
          },
          (value) {
            _tvRecommendationState = RequestState.loaded;
            _tvRecommendation = value;
          },
        );
      },
    );

    notifyListeners();
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveWatchlist.executeTv(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> removeFromWatchlist(TvDetail tv) async {
    final result = await removeWatchlist.executeTv(tv);

    await result.fold(
      (failure) async {
        _watchlistMessage = failure.message;
      },
      (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(tv.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatus.executeTv(id);
    _isAddedtoWatchlist = result;
    notifyListeners();
  }
}
