import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/utils/watch_type.dart';
import 'package:equatable/equatable.dart';

part 'watchlist_event.dart';
part 'watchlist_state.dart';

class WatchlistBloc extends Bloc<WatchlistEvent, WatchlistState> {
  final GetWatchlist getWatchlist;

  WatchlistBloc({required this.getWatchlist}) : super(WatchlistInitial()) {
    on<FetchWatchlist>(_onFetchWatchlist);
  }

  Future<void> _onFetchWatchlist(
      FetchWatchlist event, Emitter<WatchlistState> emit) async {
    final type = event.watchType;
    emit(WatchlistLoading());

    final isMovie = type == WatchType.movie;

    final result = isMovie
        ? await getWatchlist.executeMovie()
        : await getWatchlist.executeTv();

    result.fold(
      (failure) {
        emit(WatchlistError(failure.message));
      },
      (data) {
        if (isMovie) {
          emit(WatchlistHasData<Movie>(data as List<Movie>));
        } else {
          emit(WatchlistHasData<Tv>(data as List<Tv>));
        }
      },
    );
  }
}
