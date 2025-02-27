part of 'movie_search_bloc.dart';

sealed class MovieSearchState extends Equatable {
  const MovieSearchState();

  @override
  List<Object?> get props => [];
}

final class MovieSearchInitial extends MovieSearchState {}

class SearchEmpty extends MovieSearchState {}

class SearchLoading extends MovieSearchState {}

class SearchError extends MovieSearchState {
  final String message;

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class SearchHasData extends MovieSearchState {
  final List<Movie> result;

  const SearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
