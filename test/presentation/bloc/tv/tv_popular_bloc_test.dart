import 'package:core/presentation/bloc/tv/popular/tv_popular_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tv/get_tv_popular.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_popular_bloc_test.mocks.dart';

@GenerateMocks([GetTvPopular])
void main() {
  late MockGetTvPopular mockGetTvPopular;
  late TvPopularBloc tvPopularBloc;

  setUp(() {
    mockGetTvPopular = MockGetTvPopular();
    tvPopularBloc = TvPopularBloc(mockGetTvPopular);
  });


  group('popular tv', () {
    test('initialState should be Empty', () {
      expect(tvPopularBloc.state, equals(TvPopularInitial()));
    });

    blocTest<TvPopularBloc, TvPopularState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(TvPopularFetch()),
      expect: () => [
        TvPopularLoading(),
        TvPopularHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );

    blocTest<TvPopularBloc, TvPopularState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvPopularBloc;
      },
      act: (bloc) => bloc.add(TvPopularFetch()),
      expect: () =>
          [TvPopularLoading(), TvPopularError('Error')],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );
  });
  
}
