part of 'movie_detail_bloc.dart';

sealed class MovieDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class MovieDetailInitial extends MovieDetailState {}

final class MovieDetailLoading extends MovieDetailState {}

final class MovieDetailError extends MovieDetailState {
  final String message;

  MovieDetailError(this.message);

  @override
  List<Object?> get props => [];
}

final class MovieDetailHasData extends MovieDetailState {
  final MovieDetail result;

  MovieDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}
