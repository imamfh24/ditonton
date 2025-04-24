import 'package:core/domain/usecases/tv/get_tv_watchlist.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvWatchlist(mockTvRepository);
  });

  test('should get list of TV shows from the repository', () async {
    // arrange
    when(mockTvRepository.getTvWatchlist())
        .thenAnswer((_) async => Right(testTvList));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Right(testTvList));
  });

  test('should return failure when repository call is unsuccessful', () async {
    // arrange
    when(mockTvRepository.getTvWatchlist())
        .thenAnswer((_) async => Left(DatabaseFailure('Failed to fetch data')));
    // act
    final result = await usecase.execute();
    // assert
    expect(result, Left(DatabaseFailure('Failed to fetch data')));
  });
}