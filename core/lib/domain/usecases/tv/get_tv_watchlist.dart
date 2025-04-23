import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetTvWatchlist {
  final TvRepository _repository;
  GetTvWatchlist(this._repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return _repository.getTvWatchlist();
  }
}
