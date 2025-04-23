import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:core/presentation/bloc/movie/movie_popular/movie_popular_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'popular_movies_bloc_test.mocks.dart';

@GenerateMocks([GetPopularMovies])
void main() {
  late MockGetPopularMovies mockGetPopularMovies;
  late MoviePopularBloc moviePopularBloc;

  setUp(() {
    mockGetPopularMovies = MockGetPopularMovies();
    moviePopularBloc = MoviePopularBloc(mockGetPopularMovies);
  });

  group('popular movies', () {
    test('initialState should be Empty', () {
      expect(moviePopularBloc.state, equals(MoviePopularInitial()));
    });

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Right(testMovieList));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularFetch()),
      expect: () => [
        MoviePopularLoading(),
        MoviePopularHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );

    blocTest<MoviePopularBloc, MoviePopularState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetPopularMovies.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return moviePopularBloc;
      },
      act: (bloc) => bloc.add(MoviePopularFetch()),
      expect: () =>
          [MoviePopularLoading(), MoviePopularError('Error')],
      verify: (bloc) {
        verify(mockGetPopularMovies.execute());
      },
    );
  });


}
