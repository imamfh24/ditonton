part of 'tv_detail_bloc.dart';

sealed class TvDetailState extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvDetailInitial extends TvDetailState {}

final class TvDetailLoading extends TvDetailState {}

final class TvDetailWatchlistLoading extends TvDetailState {}

final class TvDetailError extends TvDetailState {
  final String message;

  TvDetailError(this.message);

  @override
  List<Object?> get props => [];
}

final class TvDetailHasData extends TvDetailState {
  final TvDetail result;

  TvDetailHasData(this.result);

  @override
  List<Object?> get props => [result];
}

