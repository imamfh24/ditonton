import 'package:dartz/dartz.dart';
import '../entities/movie.dart';
import '../entities/tv.dart';
import '../repositories/movie_repository.dart';
import 'package:core/core.dart';
import '../repositories/tv_repository.dart';

class GetWatchlist {
  final MovieRepository _repository;
  final TvRepository _tvRepository;

  GetWatchlist(this._repository, this._tvRepository);

  Future<Either<Failure, List<Movie>>> executeMovie() {
    return _repository.getWatchlistMovies();
  }

  Future<Either<Failure, List<Tv>>> executeTv() {
    return _tvRepository.getTvWatchlist();
  }
}
