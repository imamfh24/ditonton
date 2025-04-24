import 'package:core/domain/usecases/movies/get_movie_status_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetMovieStatusWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = GetMovieStatusWatchlist(mockMovieRepository);
  });

  const tMovieId = 1;

  test('should get watchlist status from the repository', () async {
    // arrange
    when(mockMovieRepository.isAddedToWatchlist(tMovieId))
        .thenAnswer((_) async => true);
    // act
    final result = await usecase.execute(tMovieId);
    // assert
    expect(result, true);
  });
}