import 'package:core/domain/repositories/tv_repository.dart';
import 'package:core/domain/usecases/tv/get_tv_status_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import '../../../helpers/test_helper.mocks.dart';

@GenerateMocks([TvRepository])
void main() {
  late GetTvStatusWatchlist usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvStatusWatchlist(mockTvRepository);
  });

  const tId = 1;

  test('should return watchlist status from the repository', () async {
    // arrange
    when(mockTvRepository.isTvAddedToWatchlist(tId))
        .thenAnswer((_) async => true);

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, true);
  });

  test('should return false when tv is not in the watchlist', () async {
    // arrange
    when(mockTvRepository.isTvAddedToWatchlist(tId))
        .thenAnswer((_) async => false);

    // act
    final result = await usecase.execute(tId);

    // assert
    expect(result, false);
  });
}