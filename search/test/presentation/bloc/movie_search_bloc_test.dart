import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies])
void main() {
  late MovieSearchBloc movieSearchBloc;
  late MockSearchMovies mockSearchMovies;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    movieSearchBloc = MovieSearchBloc(mockSearchMovies);
  });

  test('initial state should be empty', () {
    expect(movieSearchBloc.state, MovieSearchEmpty());
  });

  group('search movie', () {
    blocTest<MovieSearchBloc, MovieSearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(MovieSearchOnQueryChangeEvent(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<MovieSearchBloc, MovieSearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieSearchBloc;
      },
      act: (bloc) => bloc.add(MovieSearchOnQueryChangeEvent(tQuery)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        MovieSearchLoading(),
        MovieSearchError('Error'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
}
