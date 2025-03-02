part of 'tv_list_bloc.dart';



sealed class TvListState extends Equatable {
  const TvListState();
  @override
  List<Object?> get props => [];
}

final class TvListInitial extends TvListState {}

final class TvListAiringTodayInitial extends TvListState {}

final class TvListTopRatedInitial extends TvListState {}

final class TvListPopularInitial extends TvListState {}

final class TvListAiringTodayLoading extends TvListState {}

final class TvListTopRatedLoading extends TvListState {}

final class TvListPopularLoading extends TvListState {}

final class TvListNowPlayingError extends TvListState {
  final String message;

  const TvListNowPlayingError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvListAiringTodayError extends TvListState {
  final String message;

  const TvListAiringTodayError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvListTopRatedError extends TvListState {
  final String message;

  const TvListTopRatedError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvListPopularError extends TvListState {
  final String message;

  const TvListPopularError(this.message);

  @override
  List<Object> get props => [message];
}

final class TvListAiringTodayHasData extends TvListState {
  final List<Tv> result;

  const TvListAiringTodayHasData(this.result);

  @override
  List<Object> get props => [result];
}

final class TvListTopRatedHasData extends TvListState {
  final List<Tv> result;

  const TvListTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

final class TvListPopularHasData extends TvListState {
  final List<Tv> result;

  const TvListPopularHasData(this.result);

  @override
  List<Object> get props => [result];
}

