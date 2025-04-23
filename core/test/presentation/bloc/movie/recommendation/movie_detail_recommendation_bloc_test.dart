import 'package:bloc_test/bloc_test.dart';
import 'package:core/domain/usecases/movies/get_movie_recommendations.dart';
import 'package:core/presentation/bloc/movie/detail/recommendation/movie_detail_recommendation_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../../dummy_data/dummy_objects.dart';
import 'movie_detail_recommendation_bloc_test.mocks.dart';

@GenerateMocks([GetMovieRecommendations])
void main() {
  late MovieDetailRecommendationBloc movieDetailRecommendationBloc;
  late MockGetMovieRecommendations mockGetMovieRecommendations;

  setUp(() {
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    movieDetailRecommendationBloc = MovieDetailRecommendationBloc(mockGetMovieRecommendations);
  });


  test('initial state should be MovieDetailRecommendationInitial', () {
    expect(movieDetailRecommendationBloc.state, MovieDetailRecommendationInitial());
  });

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'emits [Loading, HasData] when data is fetched successfully',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right(testMovieList));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) =>
        bloc.add(FetchMovieDetailRecommendationEvent(testId)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationHasData(testMovieList),
    ],
    verify: (bloc) {
      verify(mockGetMovieRecommendations.execute(testId));
    },
  );

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'emits [Loading, Empty] when data is fetched but empty',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Right([]));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) =>
        bloc.add(FetchMovieDetailRecommendationEvent(testId)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationEmpty(),
    ],
  );

  blocTest<MovieDetailRecommendationBloc, MovieDetailRecommendationState>(
    'emits [Loading, Error] when fetching data fails',
    build: () {
      when(mockGetMovieRecommendations.execute(testId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return movieDetailRecommendationBloc;
    },
    act: (bloc) =>
        bloc.add(FetchMovieDetailRecommendationEvent(testId)),
    expect: () => [
      MovieDetailRecommendationLoading(),
      MovieDetailRecommendationError('Server Failure'),
    ],
  );
}