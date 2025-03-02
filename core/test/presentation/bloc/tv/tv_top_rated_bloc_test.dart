import 'package:core/presentation/bloc/tv/top_rated/tv_top_rated_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_top_rated_bloc_test.mocks.dart';

@GenerateMocks([GetTvTopRated])
void main() {
  late MockGetTvTopRated mockGetTvTopRated;
  late TvTopRatedBloc tvTopRatedBloc;

  setUp(() {
    mockGetTvTopRated = MockGetTvTopRated();
    tvTopRatedBloc = TvTopRatedBloc(mockGetTvTopRated);
  });

  group('top rated tv', () {
    test('initialState should be Empty', () {
      expect(tvTopRatedBloc.state, equals(TvTopRatedInitial()));
    });

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedFetch()),
      expect: () => [
        TvTopRatedLoading(),
        TvTopRatedHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );

    blocTest<TvTopRatedBloc, TvTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvTopRatedBloc;
      },
      act: (bloc) => bloc.add(TvTopRatedFetch()),
      expect: () => [TvTopRatedLoading(), TvTopRatedError('Error')],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );
  });


}
