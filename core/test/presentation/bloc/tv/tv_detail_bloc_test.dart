import 'package:core/presentation/bloc/tv/detail/tv_detail_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:core/utils/failure.dart';
import 'package:core/domain/usecases/get_tv_detail.dart';
import 'package:core/domain/usecases/get_tv_recommendations.dart';
import 'package:core/domain/usecases/get_watchlist_status.dart';
import 'package:core/domain/usecases/remove_watchlist.dart';
import 'package:core/domain/usecases/save_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:bloc_test/bloc_test.dart';

import '../../../dummy_data/dummy_objects.dart';
import 'tv_detail_bloc_test.mocks.dart';

@GenerateMocks([
  GetTvDetail,
  GetTvRecommendations,
  GetWatchListStatus,
  SaveWatchlist,
  RemoveWatchlist,
])
void main() {
  late TvDetailBloc tvDetailBloc;
  late MockGetTvDetail mockGetTvDetail;
  late MockGetTvRecommendations mockGetTvRecommendations;
  late MockGetWatchListStatus mockGetWatchlistStatus;
  late MockSaveWatchlist mockSaveWatchlist;
  late MockRemoveWatchlist mockRemoveWatchlist;

  setUp(() {
    mockGetTvDetail = MockGetTvDetail();
    mockGetTvRecommendations = MockGetTvRecommendations();
    mockGetWatchlistStatus = MockGetWatchListStatus();
    mockSaveWatchlist = MockSaveWatchlist();
    mockRemoveWatchlist = MockRemoveWatchlist();
    tvDetailBloc = TvDetailBloc(
      mockGetTvDetail,
      mockGetTvRecommendations,
      mockGetWatchlistStatus,
      mockSaveWatchlist,
      mockRemoveWatchlist,
    );
  });

  group('Get Tv Detail and Recommendation', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData] when tv detail data and recommendation is gotten successfuly',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(testId))
            .thenAnswer((_) async => Right(testTvList));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailFetch(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTvDetail),
        TvDetailRecommendationLoading(),
        TvDetailRecommendationHasData(testTvList)
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
        verify(mockGetTvRecommendations.execute(testId));
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

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, Error] when tv detail data gotten successfuly but recommendation unsuccesfuly',
      build: () {
        when(mockGetTvDetail.execute(testId))
            .thenAnswer((_) async => Right(testTvDetail));
        when(mockGetTvRecommendations.execute(testId))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailFetch(testId)),
      expect: () => [
        TvDetailLoading(),
        TvDetailHasData(testTvDetail),
        TvDetailRecommendationLoading(),
        TvDetailRecommendationError('Error')
      ],
      verify: (bloc) {
        verify(mockGetTvDetail.execute(testId));
        verify(mockGetTvRecommendations.execute(testId));
      },
    );
  });

  group('Watchlist', () {
    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist and status watchlist true successfuly',
      build: () {
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailAddWatchlist(testTvDetail)),
      expect: () => [
        TvDetailWatchlistLoading(),
        TvDetailWatchlistMessage('Success'),
        TvDetailIsAddToWatchlist(isAddedToWatchlist: true)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeTv(testTvDetail);
        mockGetWatchlistStatus.executeTv(testTvDetail.id);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist successfuly and status watchlist false',
      build: () {
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => Right('Success'));
        when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailAddWatchlist(testTvDetail)),
      expect: () => [
        TvDetailWatchlistLoading(),
        TvDetailWatchlistMessage('Success'),
        TvDetailIsAddToWatchlist(isAddedToWatchlist: false)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeTv(testTvDetail);
        mockGetWatchlistStatus.executeTv(testTvDetail.id);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist unsuccessfuly and status watchlist false',
      build: () {
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => false);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailAddWatchlist(testTvDetail)),
      expect: () => [
        TvDetailWatchlistLoading(),
        TvDetailWatchlistMessage('Error'),
        TvDetailIsAddToWatchlist(isAddedToWatchlist: false)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeTv(testTvDetail);
        mockGetWatchlistStatus.executeTv(testTvDetail.id);
      },
    );

    blocTest<TvDetailBloc, TvDetailState>(
      'Should emit [Loading, HasData, AddToWatchlist] when add watchlist unsuccessfuly and status watchlist true',
      build: () {
        when(mockSaveWatchlist.executeTv(testTvDetail))
            .thenAnswer((_) async => Left(ServerFailure('Error')));
        when(mockGetWatchlistStatus.executeTv(testTvDetail.id))
            .thenAnswer((_) async => true);
        return tvDetailBloc;
      },
      act: (bloc) => bloc.add(TvDetailAddWatchlist(testTvDetail)),
      expect: () => [
        TvDetailWatchlistLoading(),
        TvDetailWatchlistMessage('Error'),
        TvDetailIsAddToWatchlist(isAddedToWatchlist: true)
      ],
      verify: (bloc) {
        mockSaveWatchlist.executeTv(testTvDetail);
        mockGetWatchlistStatus.executeTv(testTvDetail.id);
      },
    );

  });
}
