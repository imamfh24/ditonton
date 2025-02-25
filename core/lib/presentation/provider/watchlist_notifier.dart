import 'package:core/core.dart';
import '../../domain/entities/movie.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_watchlist_movies.dart';
import 'package:flutter/foundation.dart';

class WatchlistNotifier extends ChangeNotifier {
  var _watchlistMovies = <Movie>[];
  List<Movie> get watchlistMovies => _watchlistMovies;

  var _watchlistState = RequestState.empty;
  RequestState get watchlistState => _watchlistState;

  List<Tv> _watchlistTv = [];
  List<Tv> get watchlistTv => _watchlistTv;

  var _watchlistTvState = RequestState.empty;
  RequestState get watchlistTvState => _watchlistTvState;

  String _message = '';
  String get message => _message;

  WatchlistNotifier({required this.getWatchlist});

  final GetWatchlist getWatchlist;

  Future<void> fetchWatchlistMovies() async {
    _watchlistState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlist.executeMovie();
    result.fold(
      (failure) {
        _watchlistState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistState = RequestState.loaded;
        _watchlistMovies = moviesData;
        notifyListeners();
      },
    );
  }

  Future<void> fetchWatchlistTv() async {
    _watchlistTvState = RequestState.loading;
    notifyListeners();

    final result = await getWatchlist.executeTv();
    result.fold(
      (failure) {
        _watchlistTvState = RequestState.error;
        _message = failure.message;
        notifyListeners();
      },
      (moviesData) {
        _watchlistTvState = RequestState.loaded;
        _watchlistTv = moviesData;
        notifyListeners();
      },
    );
  }
}
