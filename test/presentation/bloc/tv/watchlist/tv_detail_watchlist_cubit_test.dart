import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv/get_tv_status_watchlist.dart';
import 'package:core/domain/usecases/tv/remove_tv_from_watchlist.dart';
import 'package:core/domain/usecases/tv/save_tv_to_watchlist.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/tv/detail/watchlist/tv_detail_watchlist_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetTvStatusWatchlist, SaveTvToWatchlist, RemoveTvFromWatchlist])
void main() {
  late TvDetailWatchlistCubit cubit;
  late MockGetTvStatusWatchlist mockGetTvStatusWatchlist;
  late MockSaveTvToWatchlist mockSaveTvToWatchlist;
  late MockRemoveTvFromWatchlist mockRemoveTvFromWatchlist;

  setUp(() {
    mockGetTvStatusWatchlist = MockGetTvStatusWatchlist();
    mockSaveTvToWatchlist = MockSaveTvToWatchlist();
    mockRemoveTvFromWatchlist = MockRemoveTvFromWatchlist();
    cubit = TvDetailWatchlistCubit(
      mockGetTvStatusWatchlist,
      mockSaveTvToWatchlist,
      mockRemoveTvFromWatchlist,
    );
  });

  group('TvDetailWatchlistCubit', () {
    test('initial state should be TvDetailWatchlistState.initial()', () {
      expect(cubit.state, TvDetailWatchlistState.initial());
    });

    blocTest<TvDetailWatchlistCubit, TvDetailWatchlistState>(
      'should emit updated state when loadStatus is called',
      build: () {
        when(mockGetTvStatusWatchlist.execute(testId))
            .thenAnswer((_) async => true);
        return cubit;
      },
      act: (cubit) => cubit.loadStatus(testId),
      expect: () => [
        TvDetailWatchlistState.initial().copyWith(
          isAddedToWatchlist: true,
          message: '',
        ),
      ],
    );

    blocTest<TvDetailWatchlistCubit, TvDetailWatchlistState>(
      'should emit success message when addWatchlist is called successfully',
      build: () {
        when(mockSaveTvToWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Added to Watchlist'));
        return cubit;
      },
      act: (cubit) => cubit.addWatchlist(testTvDetail),
      expect: () => [
        TvDetailWatchlistState.initial().copyWith(
          isAddedToWatchlist: true,
          message: 'Added to Watchlist',
        ),
      ],
    );

    blocTest<TvDetailWatchlistCubit, TvDetailWatchlistState>(
      'should emit failure message when addWatchlist fails',
      build: () {
        when(mockSaveTvToWatchlist.execute(testTvDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to add to Watchlist')),
        );
        return cubit;
      },
      act: (cubit) => cubit.addWatchlist(testTvDetail),
      expect: () => [
        TvDetailWatchlistState.initial().copyWith(
          isAddedToWatchlist: false,
          message: 'Failed to add to Watchlist',
        ),
      ],
    );

    blocTest<TvDetailWatchlistCubit, TvDetailWatchlistState>(
      'should emit success message when removeWatchlist is called successfully',
      build: () {
        when(mockRemoveTvFromWatchlist.execute(testTvDetail))
            .thenAnswer((_) async => const Right('Removed from Watchlist'));
        return cubit;
      },
      act: (cubit) => cubit.removeWatchlist(testTvDetail),
      expect: () => [
        TvDetailWatchlistState.initial().copyWith(
          isAddedToWatchlist: false,
          message: 'Removed from Watchlist',
        ),
      ],
    );

    blocTest<TvDetailWatchlistCubit, TvDetailWatchlistState>(
      'should emit failure message when removeWatchlist fails',
      build: () {
        when(mockRemoveTvFromWatchlist.execute(testTvDetail)).thenAnswer(
          (_) async => Left(DatabaseFailure('Failed to remove from Watchlist')),
        );
        return cubit;
      },
      act: (cubit) => cubit.removeWatchlist(testTvDetail),
      expect: () => [
        TvDetailWatchlistState.initial().copyWith(
          isAddedToWatchlist: true,
          message: 'Failed to remove from Watchlist',
        ),
      ],
    );
  });
}