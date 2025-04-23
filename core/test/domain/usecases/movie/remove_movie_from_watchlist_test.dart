import 'package:core/core.dart';
import 'package:core/domain/usecases/movies/remove_movie_from_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveMovieFromWatchlist usecase;
  late MockMovieRepository mockMovieRepository;

  setUp(() {
    mockMovieRepository = MockMovieRepository();
    usecase = RemoveMovieFromWatchlist(mockMovieRepository);
  });

  test('should remove movie from watchlist in the repository', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Right('Removed from watchlist'));
  });

  test('should return failure when removing movie from watchlist fails', () async {
    // arrange
    when(mockMovieRepository.removeWatchlist(testMovieDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
    // act
    final result = await usecase.execute(testMovieDetail);
    // assert
    expect(result, Left(DatabaseFailure('Failed to remove')));
  });
}