import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movies/get_movie_watchlist.dart';
import 'package:core/presentation/bloc/movie/watchlist/movie_watchlist_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import '../../../dummy_data/dummy_objects.dart';

import 'movie_watchlist_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieWatchlist,
])
void main() {
  late MovieWatchlistBloc movieWatchlistBloc;
  late MockGetMovieWatchlist mockGetWatchlistMovies;

  setUp(() {
    mockGetWatchlistMovies = MockGetMovieWatchlist();
    movieWatchlistBloc = MovieWatchlistBloc(getWatchlist: mockGetWatchlistMovies);
  });

  test('initial state should be MovieWatchlistInitial', () {
    expect(movieWatchlistBloc.state, MovieWatchlistInitial());
  });

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, MovieWatchlistLoaded] when data is fetched successfully',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Right([testWatchlistMovie]));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieFetchWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistHasData([testWatchlistMovie]),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );

  blocTest<MovieWatchlistBloc, MovieWatchlistState>(
    'emits [MovieWatchlistLoading, MovieWatchlistError] when fetching data fails',
    build: () {
      when(mockGetWatchlistMovies.execute())
          .thenAnswer((_) async => Left(DatabaseFailure('Failed to fetch data')));
      return movieWatchlistBloc;
    },
    act: (bloc) => bloc.add(MovieFetchWatchlist()),
    expect: () => [
      MovieWatchlistLoading(),
      MovieWatchlistError('Failed to fetch data'),
    ],
    verify: (bloc) {
      verify(mockGetWatchlistMovies.execute());
    },
  );
}