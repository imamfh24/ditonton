import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_movie_watchlist.dart';
import 'package:equatable/equatable.dart';

part 'movie_watchlist_event.dart';
part 'movie_watchlist_state.dart';

class MovieWatchlistBloc extends Bloc<MovieWatchlistEvent, MovieWatchlistState> {
  final GetMovieWatchlist getWatchlist;

  MovieWatchlistBloc({required this.getWatchlist}) : super(MovieWatchlistInitial()) {
    on<MovieFetchWatchlist>(_onFetchWatchlist);
  }

  Future<void> _onFetchWatchlist(
      MovieFetchWatchlist event, Emitter<MovieWatchlistState> emit) async {
    emit(MovieWatchlistLoading());

    final result = await getWatchlist.execute();

    result.fold(
      (failure) {
        emit(MovieWatchlistError(failure.message));
      },
      (data) {
          emit(MovieWatchlistHasData(data));
      },
    );
  }
}
