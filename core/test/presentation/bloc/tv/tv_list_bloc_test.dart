import 'package:core/presentation/bloc/tv/list/tv_list_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_tv_airing_today.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_list_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvAiringToday,
  GetTvPopular,
  GetTvTopRated,
])
void main() {
  late TvListBloc tvListBloc;
  late MockGetTvAiringToday mockGetTvAiringToday;
  late MockGetTvPopular mockGetTvPopular;
  late MockGetTvTopRated mockGetTvTopRated;

  setUp(() {
    mockGetTvAiringToday = MockGetTvAiringToday();
    mockGetTvPopular = MockGetTvPopular();
    mockGetTvTopRated = MockGetTvTopRated();
    tvListBloc = TvListBloc(
      mockGetTvAiringToday,
      mockGetTvPopular,
      mockGetTvTopRated,
    );
  });

  group('airing today tv list', () {
    test('initialState should be Empty', () {
      expect(tvListBloc.state, equals(TvListInitial()));
    });

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvAiringToday.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchAiringToday()),
      expect: () => [
        TvListAiringTodayLoading(),
        TvListAiringTodayHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvAiringToday.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvAiringToday.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchAiringToday()),
      expect: () =>
          [TvListAiringTodayLoading(), TvListAiringTodayError('Error')],
      verify: (bloc) {
        verify(mockGetTvAiringToday.execute());
      },
    );
  });

  group('popular tv list', () {
    test('initialState should be Empty', () {
      expect(tvListBloc.state, equals(TvListInitial()));
    });

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchPopular()),
      expect: () => [
        TvListPopularLoading(),
        TvListPopularHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvPopular.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchPopular()),
      expect: () => [TvListPopularLoading(), TvListPopularError('Error')],
      verify: (bloc) {
        verify(mockGetTvPopular.execute());
      },
    );
  });

  group('top rated tv list', () {
    test('initialState should be Empty', () {
      expect(tvListBloc.state, equals(TvListInitial()));
    });

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchTopRated()),
      expect: () => [
        TvListTopRatedLoading(),
        TvListTopRatedHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );

    blocTest<TvListBloc, TvListState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvTopRated.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvListBloc;
      },
      act: (bloc) => bloc.add(TvListFetchTopRated()),
      expect: () => [TvListTopRatedLoading(), TvListTopRatedError('Error')],
      verify: (bloc) {
        verify(mockGetTvTopRated.execute());
      },
    );
  });
}
