part of 'tv_search_bloc.dart';

sealed class TvSearchEvent extends Equatable {
  const TvSearchEvent();

  @override
  List<Object?> get props => [];
}

class TvSearchOnQueryChangeEvent extends TvSearchEvent {
  final String query;
  const TvSearchOnQueryChangeEvent(this.query);

  @override
  List<Object?> get props => [query];
}
