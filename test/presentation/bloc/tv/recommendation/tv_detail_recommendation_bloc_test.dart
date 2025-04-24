import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/tv/get_tv_recommendations.dart';
import 'package:core/presentation/bloc/tv/detail/recommendation/tv_detail_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'tv_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetTvRecommendations])
void main() {
  late TvDetailRecommendationBloc tvDetailRecommendationBloc;
  late MockGetTvRecommendations mockGetTvRecommendations;

  setUp(() {
    mockGetTvRecommendations = MockGetTvRecommendations();
    tvDetailRecommendationBloc = TvDetailRecommendationBloc(mockGetTvRecommendations);
  });

  test('initial state should be TvDetailRecommendationInitial', () {
    expect(tvDetailRecommendationBloc.state, TvDetailRecommendationInitial());
  });

  blocTest<TvDetailRecommendationBloc, TvDetailRecommendationState>(
    'emits [TvDetailRecommendationLoading, TvDetailRecommendationLoaded] when data is fetched successfully',
    build: () {
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testTvList));
      return tvDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetailRecommendationEvent(testId)),
    expect: () => [
      TvDetailRecommendationLoading(),
      TvDetailRecommendationHasData(testTvList),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testId));
    },
  );

  blocTest<TvDetailRecommendationBloc, TvDetailRecommendationState>(
    'emits [TvDetailRecommendationLoading, TvDetailRecommendationError] when fetching data fails',
    build: () {
      when(mockGetTvRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return tvDetailRecommendationBloc;
    },
    act: (bloc) => bloc.add(FetchTvDetailRecommendationEvent(testId)),
    expect: () => [
      TvDetailRecommendationLoading(),
      TvDetailRecommendationError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockGetTvRecommendations.execute(testId));
    },
  );
}