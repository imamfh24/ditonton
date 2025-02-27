import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_tv_airing_today.dart';
import 'package:core/presentation/provider/tv_airing_today_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'tv_list_notifier_test.mocks.dart';

@GenerateMocks([GetTvAiringToday])
void main() {
  late MockGetTvAiringToday mockGetTvAiringToday;
  late TvAiringTodayNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTvAiringToday = MockGetTvAiringToday();
    notifier = TvAiringTodayNotifier(getTvAiringToday: mockGetTvAiringToday)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTvAiringToday.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    notifier.fetchTvAiringToday();
    // assert
    expect(notifier.state, RequestState.loading);
    expect(listenerCallCount, 1);
  });

  test('should change tv data when data is gotten successfully', () async {
    // arrange
    when(mockGetTvAiringToday.execute())
        .thenAnswer((_) async => Right(testTvList));
    // act
    await notifier.fetchTvAiringToday();
    // assert
    expect(notifier.state, RequestState.loaded);
    expect(notifier.tvAiringToday, testTvList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTvAiringToday.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTvAiringToday();
    // assert
    expect(notifier.state, RequestState.error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
