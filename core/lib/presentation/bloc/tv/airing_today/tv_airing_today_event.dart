part of 'tv_airing_today_bloc.dart';

sealed class TvAiringTodayEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvAiringTodayFetch extends TvAiringTodayEvent {}