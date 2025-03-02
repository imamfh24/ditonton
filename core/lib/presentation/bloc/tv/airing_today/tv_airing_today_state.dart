part of 'tv_airing_today_bloc.dart';

sealed class TvAiringTodayState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvAiringTodayInitial extends TvAiringTodayState {}

final class TvAiringTodayLoading extends TvAiringTodayState {}

final class TvAiringTodayError extends TvAiringTodayState {
  final String message;
  TvAiringTodayError(this.message);

  @override
  List<Object?> get props => [message];
}

final class TvAiringTodayHasData extends TvAiringTodayState {
  final List<Tv> results;
  TvAiringTodayHasData(this.results);

  @override
  List<Object?> get props => [results];
}
