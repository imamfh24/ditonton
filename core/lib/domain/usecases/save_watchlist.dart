import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/entities/tv_detail.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class SaveWatchlist {
  final MovieRepository repository;
  final TvRepository tvRepository;

  SaveWatchlist(this.repository, this.tvRepository);

  Future<Either<Failure, String>> executeMovie(MovieDetail movie) {
    return repository.saveWatchlist(movie);
  }
  Future<Either<Failure, String>> executeTv(TvDetail movie) {
    return tvRepository.saveTvWatchlist(movie);
  }
}
