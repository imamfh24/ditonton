import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movies/get_movie_status_watchlist.dart';
import 'package:core/domain/usecases/movies/remove_movie_from_watchlist.dart';
import 'package:core/domain/usecases/movies/save_movie_to_watchlist.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_cubit.dart';
import 'package:core/presentation/bloc/movie/detail/watchlist/movie_detail_watchlist_state.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_watchlist_cubit_test.mocks.dart';

@GenerateMocks([GetMovieStatusWatchlist, SaveMovieToWatchlist, RemoveMovieFromWatchlist])
void main() {
  late MovieDetailWatchlistCubit cubit;
  late MockGetMovieStatusWatchlist mockGetWatchListStatus;
  late MockSaveMovieToWatchlist mockSaveWatchlist;
  late MockRemoveMovieFromWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetWatchListStatus = MockGetMovieStatusWatchlist();
    mockSaveWatchlist = MockSaveMovieToWatchlist();
    mockRemoveWatchlist = MockRemoveMovieFromWatchlist();
    cubit = MovieDetailWatchlistCubit(
      mockGetWatchListStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  test('initial state should be MovieDetailWatchlistInitial', () {
    expect(cubit.state, MovieDetailWatchlistState.initial());
  });

  blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
    'should emit [MovieDetailWatchlistLoaded] when watchlist status is loaded',
    build: () {
      when(mockGetWatchListStatus.execute(testId)).thenAnswer((_) async => true);
      return cubit;
    },
    act: (cubit) => cubit.loadStatus(testId),
    expect: () => [
      MovieDetailWatchlistState.initial().copyWith(
        isAddedToWatchlist: true,
        message: '',
      ),
      ],
    verify: (cubit) {
      verify(mockGetWatchListStatus.execute(testId));
    },
  );

  blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
    'should emit [MovieDetailWatchlistSuccess] when adding to watchlist is successful',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieDetailWatchlistState.initial().copyWith(
        isAddedToWatchlist: true,
        message: 'Added to Watchlist',
      ),
    ],
    verify: (cubit) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
    'should emit [MovieDetailWatchlistError] when adding to watchlist fails',
    build: () {
      when(mockSaveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed to add')));
      return cubit;
    },
    act: (cubit) => cubit.addWatchlist(testMovieDetail),
    expect: () => [
      MovieDetailWatchlistState.initial().copyWith(
        isAddedToWatchlist: false,
        message: 'Failed to add',
      ),
    ],
    verify: (cubit) {
      verify(mockSaveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
    'should emit [MovieDetailWatchlistSuccess] when removing from watchlist is successful',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Right('Removed from Watchlist'));
      return cubit;
    },
    act: (cubit) => cubit.removeWatchlist(testMovieDetail),
    expect: () => [
      MovieDetailWatchlistState.initial().copyWith(
        isAddedToWatchlist: false,
        message: 'Removed from Watchlist',
      ),
    ],
    verify: (cubit) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );

  blocTest<MovieDetailWatchlistCubit, MovieDetailWatchlistState>(
    'should emit [MovieDetailWatchlistError] when removing from watchlist fails',
    build: () {
      when(mockRemoveWatchlist.execute(testMovieDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed to remove')));
      return cubit;
    },
    act: (cubit) => cubit.removeWatchlist(testMovieDetail),
    expect: () => [
      MovieDetailWatchlistState.initial().copyWith(
        isAddedToWatchlist: true,
        message: 'Failed to remove',
      ),
    ],
    verify: (cubit) {
      verify(mockRemoveWatchlist.execute(testMovieDetail));
    },
  );
}