part of 'movie_popular_bloc.dart';

sealed class MoviePopularEvent extends Equatable {
  const MoviePopularEvent();

  @override
  List<Object?> get props => [];
}

class MoviePopularFetch extends MoviePopularEvent {}
