import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late GetTvPopular usecase;
  late MockTvRepository mockTvRepository;

  setUp(() {
    mockTvRepository = MockTvRepository();
    usecase = GetTvPopular(mockTvRepository);
  });

  final tTv = <Tv>[];

  group('GetPopularTv Tests', () {
    test(
        'should get list of tv from the repository when execute function is called',
        () async {
      // arrange
      when(mockTvRepository.getPopularTv()).thenAnswer((_) async => Right(tTv));
      // act
      final result = await usecase.execute();
      // assert
      expect(result, Right(tTv));
    });
  });
}
