import 'package:dartz/dartz.dart';
import 'package:core/core.dart';
import '../entities/tv.dart';
import '../repositories/tv_repository.dart';

class GetTvRecommendations {
  final TvRepository repository;
  GetTvRecommendations(this.repository);

  Future<Either<Failure, List<Tv>>> execute(int id) {
    return repository.getRecommendationsTv(id);
  }
}
