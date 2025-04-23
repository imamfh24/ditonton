part of 'tv_search_bloc.dart';

sealed class TvSearchState extends Equatable {
  const TvSearchState();

  @override
  List<Object?> get props => [];
}

final class TvSearchInitial extends TvSearchState {}

class TvSearchEmpty extends TvSearchState {}

class TvSearchLoading extends TvSearchState {}

class TvSearchError extends TvSearchState {
  final String message;

  const TvSearchError(this.message);

  @override
  List<Object> get props => [message];
}

class TvSearchHasData extends TvSearchState {
  final List<Tv> result;

  const TvSearchHasData(this.result);

  @override
  List<Object> get props => [result];
}
