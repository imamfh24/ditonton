import 'package:core/domain/repositories/movie_repository.dart';

class GetMovieStatusWatchlist {
  final MovieRepository _repository;

  GetMovieStatusWatchlist(this._repository);

  Future<bool> execute(int id) async {
    return _repository.isAddedToWatchlist(id);
  }
}
