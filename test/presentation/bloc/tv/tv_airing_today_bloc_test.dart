import 'package:core/presentation/bloc/tv/airing_today/tv_airing_today_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/tv/get_tv_airing_today.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_airing_today_bloc_test.mocks.dart';

@GenerateMocks([GetTvAiringToday])
void main() {
  late MockGetTvAiringToday mockGetTvAiringToday;
  late TvAiringTodayBloc tvAiringTodayBloc;

  setUp(() {
    mockGetTvAiringToday = MockGetTvAiringToday();
    tvAiringTodayBloc = TvAiringTodayBloc(mockGetTvAiringToday);
  });


  group('airing today tv', () {
    test('initialState should be Empty', () {
      expect(tvAiringTodayBloc.state, equals(TvAiringTodayInitial()));
    });

    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'Should emit [Loading, HasData] when data is gotten successfuly',
      build: () {
        when(mockGetTvAiringToday.execute())
            .thenAnswer((_) async => Right(testTvList));
        return tvAiringTodayBloc;
      },
      act: (bloc) => bloc.add(TvAiringTodayFetch()),
      expect: () => [
        TvAiringTodayLoading(),
        TvAiringTodayHasData(testTvList),
      ],
      verify: (bloc) {
        verify(mockGetTvAiringToday.execute());
      },
    );

    blocTest<TvAiringTodayBloc, TvAiringTodayState>(
      'Should emit [Loading, HasData] when data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvAiringToday.execute())
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvAiringTodayBloc;
      },
      act: (bloc) => bloc.add(TvAiringTodayFetch()),
      expect: () => [TvAiringTodayLoading(), TvAiringTodayError('Error')],
      verify: (bloc) {
        verify(mockGetTvAiringToday.execute());
      },
    );
  });


}
