import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/get_watchlist_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetWatchlist usecase;
  late MockMovieRepository mockMovieRepository;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    mockTvRepository = MockTvRepository();
    usecase = GetWatchlist(mockMovieRepository, mockTvRepository);
  });

  test('should get list watchlist of tv from the repository', () async {
    // arrange
    when(mockTvRepository.getTvWatchlist())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.executeTv();
    // assert
    expect(result, Right(testTvList));
  });
}
