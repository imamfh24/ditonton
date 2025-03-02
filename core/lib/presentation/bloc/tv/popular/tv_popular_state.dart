part of 'tv_popular_bloc.dart';

sealed class TvPopularState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvPopularInitial extends TvPopularState {}
final class TvPopularLoading extends TvPopularState {}
final class TvPopularError extends TvPopularState {
  final String message;
  TvPopularError(this.message);

  @override
  List<Object?> get props => [message];
}
final class TvPopularHasData extends TvPopularState {
  final List<Tv> results;
  TvPopularHasData(this.results);

  @override
  List<Object?> get props => [results];
}