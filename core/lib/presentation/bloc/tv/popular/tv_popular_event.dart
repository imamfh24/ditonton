part of 'tv_popular_bloc.dart';

sealed class TvPopularEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvPopularFetch extends TvPopularEvent {}
