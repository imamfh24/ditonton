import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:ditonton/presentation/provider/tv_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([
  GetTvAiringToday,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late TvListNotifier provider;
  late MockGetTvAiringToday mockGetTvAiringToday;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvAiringToday = MockGetTvAiringToday();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    provider = TvListNotifier(
      getTvAiringToday: mockGetTvAiringToday,
      getTvPopular: mockGetTvPopular,
      getTvTopRated: mockGetTvTopRated,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('now playing tvs', () {
    test('initialState should be Empty', () {
      expect(provider.tvAiringState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvAiringToday();
      // assert
      verify(mockGetTvAiringToday.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvAiringToday();
      // assert
      expect(provider.tvAiringState, RequestState.Loading);
    });

    test('should change tvs when data is gotten successfully', () async {
      // arrange
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvAiringToday();
      // assert
      expect(provider.tvAiringState, RequestState.Loaded);
      expect(provider.tvAiringToday, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvAiringToday.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvAiringToday();
      // assert
      expect(provider.tvAiringState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvPopular();
      // assert
      expect(provider.tvPopularState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvPopular();
      // assert
      expect(provider.tvPopularState, RequestState.Loaded);
      expect(provider.tvPopular, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvPopular.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvPopular();
      // assert
      expect(provider.tvPopularState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated tvs', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      provider.fetchTvTopRated();
      // assert
      expect(provider.tvTopRatedState, RequestState.Loading);
    });

    test('should change tvs data when data is gotten successfully', () async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Right(testTvList));
      // act
      await provider.fetchTvTopRated();
      // assert
      expect(provider.tvTopRatedState, RequestState.Loaded);
      expect(provider.tvTopRated, testTvList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTvTopRated.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTvTopRated();
      // assert
      expect(provider.tvTopRatedState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
