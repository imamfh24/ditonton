import 'package:core/presentation/bloc/movie/detail/movie_detail_bloc.dart';
import 'package:core/utils/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:core/domain/usecases/get_movie_detail.dart';
import 'package:core/domain/usecases/get_movie_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'movie_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetMovieDetail,
  GetMovieRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late MovieDetailBloc movieDetailBloc;
  late MockGetMovieDetail mockGetMovieDetail;
  late MockGetMovieRecommendations mockGetMovieRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetMovieDetail = MockGetMovieDetail();
    mockGetMovieRecommendations = MockGetMovieRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    movieDetailBloc = MovieDetailBloc(
      mockGetMovieDetail,
      mockGetMovieRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  group('Get Movie Detail and Recommendation', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData] when movie detail data and recommendation is gotten successfuly',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(testId))
            .thenAnswer((_) async => Right(testMovieList));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailFetch(testId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
        MovieDetailRecommendationLoading(),
        MovieDetailRecommendationHasData(testMovieList)
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
        verify(mockGetMovieRecommendations.execute(testId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, Error] when movie detail data is gotten unsuccessfuly',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailFetch(testId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailError('Error'),
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, Error] when movie detail data gotten successfuly but recommendation unsuccesfuly',
      build: () {
        when(mockGetMovieDetail.execute(testId))
            .thenAnswer((_) async => Right(testMovieDetail));
        when(mockGetMovieRecommendations.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailFetch(testId)),
      expect: () => [
        MovieDetailLoading(),
        MovieDetailHasData(testMovieDetail),
        MovieDetailRecommendationLoading(),
        MovieDetailRecommendationError('Error')
      ],
      verify: (bloc) {
        verify(mockGetMovieDetail.execute(testId));
        verify(mockGetMovieRecommendations.execute(testId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist and status watchlist true successfuly',
      build: () {
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailAddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailWatchlistLoading(),
        MovieDetailWatchlistMessage('Success'),
        MovieDetailIsAddToWatchlist(isAddedToWatchlist: true)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeMovie(testMovieDetail);
        mockGetWatchlistStatus.executeMovie(testMovieDetail.id);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist successfuly and status watchlist false',
      build: () {
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailAddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailWatchlistLoading(),
        MovieDetailWatchlistMessage('Success'),
        MovieDetailIsAddToWatchlist(isAddedToWatchlist: false)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeMovie(testMovieDetail);
        mockGetWatchlistStatus.executeMovie(testMovieDetail.id);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist unsuccessfuly and status watchlist false',
      build: () {
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => false);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailAddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailWatchlistLoading(),
        MovieDetailWatchlistMessage('Error'),
        MovieDetailIsAddToWatchlist(isAddedToWatchlist: false)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeMovie(testMovieDetail);
        mockGetWatchlistStatus.executeMovie(testMovieDetail.id);
      },
    );

    blocTest<MovieDetailBloc, MovieDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist unsuccessfuly and status watchlist true',
      build: () {
        when(mockSaveWatchlist.executeMovie(testMovieDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        when(mockGetWatchlistStatus.executeMovie(testMovieDetail.id))
            .thenAnswer((_) async => true);
        return movieDetailBloc;
      },
      act: (bloc) => bloc.add(MovieDetailAddWatchlist(testMovieDetail)),
      expect: () => [
        MovieDetailWatchlistLoading(),
        MovieDetailWatchlistMessage('Error'),
        MovieDetailIsAddToWatchlist(isAddedToWatchlist: true)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeMovie(testMovieDetail);
        mockGetWatchlistStatus.executeMovie(testMovieDetail.id);
      },
    );

  });
}
