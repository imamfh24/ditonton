part of 'movie_search_bloc.dart';

sealed class MovieSearchEvent {
  const MovieSearchEvent();

}

class MovieSearchOnQueryChangeEvent extends MovieSearchEvent {
  final String query;
  const MovieSearchOnQueryChangeEvent(this.query);

}
