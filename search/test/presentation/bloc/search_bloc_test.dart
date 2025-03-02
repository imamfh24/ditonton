import 'package:core/utils/failure.dart';
import 'package:core/utils/watch_type.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/presentation/bloc/search/search_bloc.dart';
import 'package:search/search.dart';
import '../../dummy_data/dummy_objects.dart';
import 'package:bloc_test/bloc_test.dart';

import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchMovies, SearchTv])
void main() {
  late SearchBloc searchBloc;
  late MockSearchMovies mockSearchMovies;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchMovies = MockSearchMovies();
    mockSearchTv = MockSearchTv();
    searchBloc = SearchBloc(mockSearchMovies, mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(searchBloc.state, SearchEmpty());
  });

  group('search movie', () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Right(testMovieList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery, WatchType.movie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(testMovieList),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchMovies.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery, WatchType.movie)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Error'),
      ],
      verify: (bloc) {
        verify(mockSearchMovies.execute(tQuery));
      },
    );
  });
  
  group('search tv', () {
    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Right(testTvList));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery, WatchType.tv)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      },
    );

    blocTest<SearchBloc, SearchState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockSearchTv.execute(tQuery))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return searchBloc;
      },
      act: (bloc) => bloc.add(OnQueryChangeEvent(tQuery, WatchType.tv)),
      wait: const Duration(milliseconds: 500),
      expect: () => [
        SearchLoading(),
        SearchError('Error'),
      ],
      verify: (bloc) {
        verify(mockSearchTv.execute(tQuery));
      },
    );
  });
  
}
