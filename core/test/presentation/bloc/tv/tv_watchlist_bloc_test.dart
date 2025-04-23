import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv/get_tv_watchlist.dart';
import 'package:core/presentation/bloc/tv/watchlist/tv_watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_watchlist_bloc_test.mocks.dart';
@GenerateMocks([
  GetTvWatchlist,
])
void main() {
  late TvWatchlistBloc tvWatchlistBloc;
  late MockGetTvWatchlist mockGetTvWatchlist;

  setUp(() {
    mockGetTvWatchlist = MockGetTvWatchlist();
    tvWatchlistBloc = TvWatchlistBloc(
      getWatchlist: mockGetTvWatchlist,
    );
  });

  group('Tv Watchlist Bloc Test', () {
    test('initial state should be TvWatchlistInitial', () {
      expect(tvWatchlistBloc.state, TvWatchlistInitial());
    });

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit [TvWatchlistLoading, TvWatchlistLoaded] when data is gotten successfully',
      build: () {
        when(mockGetTvWatchlist.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvFetchWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvWatchlist.execute());
      },
    );

    blocTest<TvWatchlistBloc, TvWatchlistState>(
      'should emit [TvWatchlistLoading, TvWatchlistError] when getting data fails',
      build: () {
        when(mockGetTvWatchlist.execute())
            .thenAnswer((_) async => Left(DatabaseFailure('Failed to fetch data')));
        return tvWatchlistBloc;
      },
      act: (bloc) => bloc.add(TvFetchWatchlist()),
      expect: () => [
        TvWatchlistLoading(),
        TvWatchlistError('Failed to fetch data'),
      ],
      verify: (bloc) {
        verify(mockGetTvWatchlist.execute());
      },
    );
  });
}