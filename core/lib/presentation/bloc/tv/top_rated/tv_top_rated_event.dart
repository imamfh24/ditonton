part of 'tv_top_rated_bloc.dart';

sealed class TvTopRatedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class TvTopRatedFetch extends TvTopRatedEvent {}
