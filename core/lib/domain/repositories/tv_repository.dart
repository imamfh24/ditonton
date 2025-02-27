import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure ,List<Tv>>> getTvAiringToday();
  Future<Either<Failure ,List<Tv>>> getPopularTv();
  Future<Either<Failure ,List<Tv>>> getTopRatedTv();
  Future<Either<Failure ,TvDetail>> getTvDetail(int id);
  Future<Either<Failure ,List<Tv>>> getRecommendationsTv(int id);
  Future<Either<Failure ,List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail data);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail data);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getTvWatchlist();
}