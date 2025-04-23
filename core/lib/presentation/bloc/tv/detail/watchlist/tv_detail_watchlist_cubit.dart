import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/usecases/tv/get_tv_status_watchlist.dart';
import 'package:core/domain/usecases/tv/remove_tv_from_watchlist.dart';
import 'package:core/domain/usecases/tv/save_tv_to_watchlist.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_state.dart';

class TvDetailWatchlistCubit extends Cubit<TvDetailWatchlistState> {
  final GetTvStatusWatchlist getTvStatusWatchlist;
  final SaveTvToWatchlist saveTvToWatchlist;
  final RemoveTvFromWatchlist removeTvFromWatchlist;
  TvDetailWatchlistCubit(this.getTvStatusWatchlist,
      this.saveTvToWatchlist, this.removeTvFromWatchlist)
      : super(TvDetailWatchlistState.initial());

  Future<void> loadStatus(int tvId) async {
    final isInWatchlist = await getTvStatusWatchlist.execute(tvId);
    emit(
      state.copyWith(
        isAddedToWatchlist: isInWatchlist,
        message: '',
      ),
    );
  }

  Future<void> addWatchlist(TvDetail tv) async {
    final result = await saveTvToWatchlist.execute(tv);
    result.fold(
      (failure) {
        emit(state.copyWith(
          isAddedToWatchlist: false,
          message: failure.message,
        ));
      },
      (message) {
        emit(state.copyWith(
          isAddedToWatchlist: true,
          message: message,
        ));
      },
    );
  }

  Future<void> removeWatchlist(TvDetail movie) async{
    final result = await removeTvFromWatchlist.execute(movie);
    result.fold(
      (failure) {
        emit(state.copyWith(
          isAddedToWatchlist: true,
          message: failure.message,
        ));
      },
      (message) {
        emit(state.copyWith(
          isAddedToWatchlist: false,
          message: message,
        ));
      },
    );
  }
}
