import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/utils/state_enum.dart';
import 'package:core/domain/usecases/get_watchlist_movies.dart';
import 'package:core/presentation/provider/watchlist_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import 'watchlist_notifier_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistNotifier provider;
  late MockGetWatchlist mockGetWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetWatchlist = MockGetWatchlist();
    provider = WatchlistNotifier(
      getWatchlist: mockGetWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  group('watchlist movies', () {
    test('should change movies data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetWatchlist.executeMovie())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistState, RequestState.loaded);
      expect(provider.watchlistMovies, [testWatchlistMovie]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlist.executeMovie())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistMovies();
      // assert
      expect(provider.watchlistState, RequestState.error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
  group('watchlist tv', () {
    test('should change tv data when data is gotten successfully', () async {
      // arrange
      when(mockGetWatchlist.executeTv())
          .thenAnswer((_) async => Right([testWatchlistTv]));
      // act
      await provider.fetchWatchlistTv();
      // assert
      expect(provider.watchlistTvState, RequestState.loaded);
      expect(provider.watchlistTv, [testWatchlistTv]);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetWatchlist.executeTv())
          .thenAnswer((_) async => Left(DatabaseFailure("Can't get data")));
      // act
      await provider.fetchWatchlistTv();
      // assert
      expect(provider.watchlistTvState, RequestState.error);
      expect(provider.message, "Can't get data");
      expect(listenerCallCount, 2);
    });
  });
}
