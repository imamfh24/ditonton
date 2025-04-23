import 'package:core/core.dart';
import 'package:core/domain/usecases/tv/remove_tv_from_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late RemoveTvFromWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = RemoveTvFromWatchlist(mockTvRepository);
  });

  test('should remove tv from watchlist in the repository', () async {
    // arrange
    when(mockTvRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, Right('Removed from watchlist'));
  });

  test('should return failure when removing tv from watchlist fails', () async {
    // arrange
    when(mockTvRepository.removeTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, Left(DatabaseFailure('Failed to remove')));
  });
}