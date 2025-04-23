import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:search/search.dart';

import 'package:bloc_test/bloc_test.dart';

import '../../dummy_data/dummy_objects.dart';
import 'search_bloc_test.mocks.dart';

@GenerateMocks([SearchTv])
void main() {
  late TvSearchBloc tvSearchBloc;
  late MockSearchTv mockSearchTv;

  setUp(() {
    mockSearchTv = MockSearchTv();
    tvSearchBloc = TvSearchBloc(mockSearchTv);
  });

  test('initial state should be empty', () {
    expect(tvSearchBloc.state, TvSearchEmpty());
  });

  group(
    'search tv',
    () {
      blocTest<TvSearchBloc, TvSearchState>(
        'Should emit [Loading, HasData] when data is gotten successfully',
        build: () {
          when(mockSearchTv.execute(tQuery))
              .thenAnswer((_) async => Right(testTvList));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(TvSearchOnQueryChangeEvent(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvSearchLoading(),
          TvSearchHasData(testTvList),
        ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQuery));
        },
      );

      blocTest<TvSearchBloc, TvSearchState>(
        'Should emit [Loading, Error] when get search is unsuccessful',
        build: () {
          when(mockSearchTv.execute(tQuery))
              .thenAnswer((_) async => Left(ServerFailure('Error')));
          return tvSearchBloc;
        },
        act: (bloc) => bloc.add(TvSearchOnQueryChangeEvent(tQuery)),
        wait: const Duration(milliseconds: 500),
        expect: () => [
          TvSearchLoading(),
          TvSearchError('Error'),
        ],
        verify: (bloc) {
          verify(mockSearchTv.execute(tQuery));
        },
      );
    },
  );
}
