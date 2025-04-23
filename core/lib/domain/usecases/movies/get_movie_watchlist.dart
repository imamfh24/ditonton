import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/repositories/movie_repository.dart';

class GetMovieWatchlist {
  final MovieRepository _repository;

  GetMovieWatchlist(this._repository);

  Future<Either<Failure, List<Movie>>> execute() {
    return _repository.getWatchlistMovies();
  }
}
