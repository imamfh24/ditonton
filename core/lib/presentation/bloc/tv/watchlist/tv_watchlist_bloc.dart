import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/tv/get_tv_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'tv_watchlist_event.dart';
part 'tv_watchlist_state.dart';

class TvWatchlistBloc extends Bloc<TvWatchlistEvent, TvWatchlistState> {
  final GetTvWatchlist getWatchlist;

  TvWatchlistBloc({required this.getWatchlist}) : super(TvWatchlistInitial()) {
    on<TvFetchWatchlist>(_onFetchWatchlist);
  }

  Future<void> _onFetchWatchlist(
      TvFetchWatchlist event, Emitter<TvWatchlistState> emit) async {
    emit(TvWatchlistLoading());

    final result = await getWatchlist.execute();

    result.fold(
      (failure) {
        emit(TvWatchlistError(failure.message));
      },
      (data) {
          emit(TvWatchlistHasData(data));
      },
    );
  }
}
