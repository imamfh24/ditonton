import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/entities/tv_detail.dart';

abstract class TvRepository {
  Future<Either<Failure ,List<Tv>>> getTvAiringToday();
  Future<Either<Failure ,List<Tv>>> getPopularTv();
  Future<Either<Failure ,List<Tv>>> getTopRatedTv();
  Future<Either<Failure ,TvDetail>> getTvDetail(int id);
  Future<Either<Failure ,List<Tv>>> getRecommendationsTv(int id);
  Future<Either<Failure ,List<Tv>>> searchTv(String query);
  Future<Either<Failure, String>> saveTvWatchlist(TvDetail movie);
  Future<Either<Failure, String>> removeTvWatchlist(TvDetail movie);
  Future<bool> isTvAddedToWatchlist(int id);
  Future<Either<Failure, List<Tv>>> getTvWatchlist();
}