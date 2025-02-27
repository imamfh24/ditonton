import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_repository.dart';

class GetWatchListStatus {
  final MovieRepository repository;
  final TvRepository tvRepository;

  GetWatchListStatus(this.repository, this.tvRepository);

  Future<bool> executeMovie(int id) async {
    return repository.isAddedToWatchlist(id);
  }

  Future<bool> executeTv(int id) async {
    return tvRepository.isTvAddedToWatchlist(id);
  }
}
