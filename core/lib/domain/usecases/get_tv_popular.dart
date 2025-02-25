import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvPopular {
  final TvRepository repository;
  GetTvPopular(this.repository);

  Future<Either<Failure, List<Tv>>> execute() {
    return repository.getPopularTv();
  }
}
