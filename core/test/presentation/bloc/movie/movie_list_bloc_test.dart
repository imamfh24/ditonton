import 'package:core/presentation/bloc/movie/list/movie_list_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_now_playing_movies.dart';
import 'package:core/domain/usecases/get_popular_movies.dart';
import 'package:core/domain/usecases/get_top_rated_movies.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';

import 'movie_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
  GetPopularMovies,
  GetTopRatedMovies,
])
void main() {
  late MovieListNowPlayingBloc movieListNowPlayingBloc;
  late MovieListTopRatedBloc movieListTopRatedBloc;
  late MovieListPopularBloc movieListPopularBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;
  late MockGetPopularMovies mockGetPopularMovies;
  late MockGetTopRatedMovies mockGetTopRatedMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    mockGetPopularMovies = MockGetPopularMovies();
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieListNowPlayingBloc = MovieListNowPlayingBloc(mockGetNowPlayingMovies);
    movieListPopularBloc = MovieListPopularBloc(mockGetPopularMovies);
    movieListTopRatedBloc = MovieListTopRatedBloc(mockGetTopRatedMovies);
  });

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieListNowPlayingBloc.state, equals(MovieListInitial()));
    });

    blocTest<MovieListNowPlayingBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchNowPlayingMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieListNowPlayingBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieListNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchNowPlayingMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(movieListTopRatedBloc.state, equals(MovieListInitial()));
    });

    blocTest<MovieListTopRatedBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchTopRatedMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieListTopRatedBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieListTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchTopRatedMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(movieListPopularBloc.state, equals(MovieListInitial()));
    });

    blocTest<MovieListPopularBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieListPopularBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchPopularMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MovieListPopularBloc, MovieListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieListPopularBloc;
      },
      act: (bloc) => bloc.add(MovieListFetchPopularMovies()),
      expect: () => [
        MovieListLoading(),
        MovieListError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });
}
