import 'package:core/core.dart';
import 'package:core/domain/usecases/tv/save_tv_to_watchlist.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late SaveTvToWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = SaveTvToWatchlist(mockTvRepository);
  });

  test('should save tv to watchlist in the repository', () async {
    // arrange
    when(mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Right('Added to watchlist'));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, Right('Added to watchlist'));
  });

  test('should return failure when save tv to watchlist fails', () async {
    // arrange
    when(mockTvRepository.saveTvWatchlist(testTvDetail))
        .thenAnswer((_) async => Left(DatabaseFailure('Failed to add')));
    // act
    final result = await usecase.execute(testTvDetail);
    // assert
    expect(result, Left(DatabaseFailure('Failed to add')));
  });
}