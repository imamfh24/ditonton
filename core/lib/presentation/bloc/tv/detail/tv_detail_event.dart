part of 'tv_detail_bloc.dart';

sealed class TvDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvDetailFetch extends TvDetailEvent {
  final int id;

  TvDetailFetch(this.id);
}

class TvDetailRecommendationFetch extends TvDetailEvent {
  final int id;

  TvDetailRecommendationFetch(this.id);
}

class TvDetailAddWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;
  TvDetailAddWatchlist(
    this.tvDetail,
  );
}

class TvDetailRemoveWatchlist extends TvDetailEvent {
  final TvDetail tvDetail;
  TvDetailRemoveWatchlist(
    this.tvDetail,
  );
}

class TvDetailLoadStatusWatchlist extends TvDetailEvent {
  final int id;
  TvDetailLoadStatusWatchlist(
    this.id,
  );
}
