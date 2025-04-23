import 'package:core/domain/usecases/movies/get_top_rated_movies.dart';
import 'package:core/presentation/bloc/movie/top_rated/movie_top_rated_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'top_rated_movies_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedMovies])
void main() {
  late MockGetTopRatedMovies mockGetTopRatedMovies;
  late MovieTopRatedBloc movieTopRatedBloc;

  setUp(() {
    mockGetTopRatedMovies = MockGetTopRatedMovies();
    movieTopRatedBloc = MovieTopRatedBloc(mockGetTopRatedMovies);
  });

  group('top rated movies', () {
    test('initialState should be Empty', () {
      expect(movieTopRatedBloc.state, equals(MovieTopRatedInitial()));
    });

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieTopRatedFetch()),
      expect: () =>
          [MovieTopRatedLoading(), MovieTopRatedHasData(testMovieList)],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );

    blocTest<MovieTopRatedBloc, MovieTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTopRatedMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieTopRatedBloc;
      },
      act: (bloc) => bloc.add(MovieTopRatedFetch()),
      expect: () =>
          [MovieTopRatedLoading(), MovieTopRatedError('Error')],
      verify: (bloc) {
        verify(mockGetTopRatedMovies.execute());
      },
    );
  });
}
