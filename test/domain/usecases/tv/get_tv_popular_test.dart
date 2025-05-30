import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvPopular(mockTvRepository);
  });


  group('GetPopularTv Tests', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      // arrange
      when(mockTvRepository.getPopularTv()).thenAnswer((_) async => Right(testTvList));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(testTvList));
    });
  });
}
