part of 'movie_top_rated_bloc.dart';

sealed class MovieTopRatedEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class MovieTopRatedFetch extends MovieTopRatedEvent {}
