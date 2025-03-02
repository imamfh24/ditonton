part of 'tv_top_rated_bloc.dart';

sealed class TvTopRatedState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvTopRatedInitial extends TvTopRatedState {}

final class TvTopRatedLoading extends TvTopRatedState {}

final class TvTopRatedError extends TvTopRatedState {
  final String message;
  TvTopRatedError(this.message);

  @override
  List<Object?> get props => [message];
}

final class TvTopRatedHasData extends TvTopRatedState {
  final List<Tv> results;
  TvTopRatedHasData(this.results);

  @override
  List<Object?> get props => [results];
}
