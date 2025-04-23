import 'package:core/domain/repositories/tv_repository.dart';

class GetTvStatusWatchlist {
  final TvRepository repository;

  GetTvStatusWatchlist(this.repository);

  Future<bool> execute(int id) async {
    return await repository.isTvAddedToWatchlist(id);
  }
}