part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieDetailFetch extends MovieDetailEvent {
  final int id;

  MovieDetailFetch(this.id);

}

class MovieDetailRecommendationFetch extends MovieDetailEvent {
  final int id;

  MovieDetailRecommendationFetch(this.id);

}

class MovieDetailAddWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  MovieDetailAddWatchlist(
    this.movieDetail,
  );

}

class MovieDetailRemoveWatchlist extends MovieDetailEvent {
  final MovieDetail movieDetail;
  MovieDetailRemoveWatchlist(
    this.movieDetail,
  );

}

class MovieDetailLoadStatusWatchlist extends MovieDetailEvent {
  final int id;
  MovieDetailLoadStatusWatchlist(
    this.id,
  );

}
