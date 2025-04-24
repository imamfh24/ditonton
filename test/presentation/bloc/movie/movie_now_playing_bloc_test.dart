import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:core/presentation/bloc/movie/now_playing/movie_now_playing_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';

import 'movie_now_playing_bloc_test.mocks.dart';

@GenerateMocks([
  GetNowPlayingMovies,
])
void main() {
  late MovieNowPlayingBloc movieNowPlayingBloc;
  late MockGetNowPlayingMovies mockGetNowPlayingMovies;

  setUp(() {
    mockGetNowPlayingMovies = MockGetNowPlayingMovies();
    movieNowPlayingBloc = MovieNowPlayingBloc(mockGetNowPlayingMovies);
  });

  group('now playing movies', () {
    test('initialState should be Empty', () {
      expect(movieNowPlayingBloc.state, equals(MovieNowPlayingInitial()));
    });

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingFetch()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );

    blocTest<MovieNowPlayingBloc, MovieNowPlayingState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetNowPlayingMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieNowPlayingBloc;
      },
      act: (bloc) => bloc.add(MovieNowPlayingFetch()),
      expect: () => [
        MovieNowPlayingLoading(),
        MovieNowPlayingError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetNowPlayingMovies.execute());
      },
    );
  });

}
