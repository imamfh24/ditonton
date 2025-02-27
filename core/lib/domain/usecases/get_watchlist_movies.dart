import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

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
