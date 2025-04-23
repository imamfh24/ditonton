import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_status_watchlist.dart';
import 'package:core/domain/usecases/movies/remove_movie_from_watchlist.dart';
import 'package:core/domain/usecases/movies/save_movie_to_watchlist.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_state.dart';

class MovieDetailWatchlistCubit extends Cubit<MovieDetailWatchlistState> {
  final GetMovieStatusWatchlist getMovieStatusWatchlist;
  final SaveMovieToWatchlist saveMovieToWatchlist;
  final RemoveMovieFromWatchlist removeMovieFromWatchlist;
  MovieDetailWatchlistCubit(this.getMovieStatusWatchlist,
      this.saveMovieToWatchlist, this.removeMovieFromWatchlist)
      : super(MovieDetailWatchlistState.initial());

  Future<void> loadStatus(int movieId) async {
    final isInWatchlist = await getMovieStatusWatchlist.execute(movieId);
    emit(
      state.copyWith(
        isAddedToWatchlist: isInWatchlist,
        message: '',
      ),
    );
  }

  Future<void> addWatchlist(MovieDetail movie) async {
    final result = await saveMovieToWatchlist.execute(movie);
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

  Future<void> removeWatchlist(MovieDetail movie) async{
    final result = await removeMovieFromWatchlist.execute(movie);
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
