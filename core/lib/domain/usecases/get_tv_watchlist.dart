import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvWatchlist {
  final TvRepository _repository;
  GetTvWatchlist(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTvWatchlist();
  }
}
