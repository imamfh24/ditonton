import 'package:core/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/tv/get_tv_detail.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    tvDetailBloc = TvDetailBloc(
      mockGetTvDetail,
    );
  });

  group('Get Tv Detail and Recommendation', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData] when tv detail data is gotten successfuly',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvDetail));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailFetch(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTvDetail),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, Error] when tv detail data is gotten unsuccessfuly',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailFetch(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
      },
    );
  });

}
