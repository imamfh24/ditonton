import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/utils/watch_type.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_movie_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'watchlist_bloc_test.mocks.dart';

@GenerateMocks([GetWatchlist])
void main() {
  late WatchlistBloc watchlistBloc;
  late MockGetWatchlist mockGetWatchlist;

  setUp(() {
    mockGetWatchlist = MockGetWatchlist();
    watchlistBloc = WatchlistBloc(
      getWatchlist: mockGetWatchlist,
    );
  });

  group('watchlist movies', () {
    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetWatchlist.executeMovie()).thenAnswer(
          (_) async => Right(
            [testWatchlistMovie],
          ),
        );
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist(
        WatchType.movie,
      )),
      expect: () => [
        WatchlistLoading(),
        WatchlistHasData([testWatchlistMovie])
      ],
    );

    blocTest<WatchlistBloc, WatchlistState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessful',
      build: () {
        when(mockGetWatchlist.executeMovie()).thenAnswer(
          (_) async => Left(
            DatabaseFailure("Can't get data"),
          ),
        );
        return watchlistBloc;
      },
      act: (bloc) => bloc.add(FetchWatchlist(
        WatchType.movie,
      )),
      expect: () => [
        WatchlistLoading(),
        WatchlistError("Can't get data"),
      ],
    );
  });

  group(
    'watchlist tv',
    () {
      blocTest<WatchlistBloc, WatchlistState>(
        'Should emit [Loading, HasData] when data is gotten successfuly',
        build: () {
          when(mockGetWatchlist.executeTv()).thenAnswer(
            (_) async => Right(
              [testWatchlistTv],
            ),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlist(
          WatchType.tv,
        )),
        expect: () => [
          WatchlistLoading(),
          WatchlistHasData([testWatchlistTv])
        ],
      );

      blocTest<WatchlistBloc, WatchlistState>(
        'Should emit [Loading, HasData] when data is gotten unsuccessful',
        build: () {
          when(mockGetWatchlist.executeTv()).thenAnswer(
            (_) async => Left(
              DatabaseFailure("Can't get data"),
            ),
          );
          return watchlistBloc;
        },
        act: (bloc) => bloc.add(FetchWatchlist(
          WatchType.tv,
        )),
        expect: () => [
          WatchlistLoading(),
          WatchlistError("Can't get data"),
        ],
      );
    },
  );
}
