import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/movie_detail.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';
import 'package:ditonton/domain/repositories/movie_repository.dart';
import 'package:ditonton/domain/repositories/tv_repository.dart';

class RemoveWatchlist {
  final MovieRepository repository;
  final TvRepository tvRepository;

  RemoveWatchlist(this.repository, this.tvRepository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return repository.removeWatchlist(movie);
  }

  Future<Either<Failure, String>> executeTv(TvDetail tv) {
    return tvRepository.removeTvWatchlist(tv);
  }
}
