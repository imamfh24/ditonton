part of 'tv_list_bloc.dart';

sealed class TvListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

final class TvListFetchAiringToday extends TvListEvent {}
final class TvListFetchPopular extends TvListEvent {}
final class TvListFetchTopRated extends TvListEvent {}
