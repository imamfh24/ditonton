part of 'movie_detail_bloc.dart';

sealed class MovieDetailEvent {
}

class MovieDetailFetch extends MovieDetailEvent {
  final int id;

  MovieDetailFetch(this.id);

}