part of 'tv_search_bloc.dart';

sealed class TvSearchEvent {
  const TvSearchEvent();

}

class TvSearchOnQueryChangeEvent extends TvSearchEvent {
  final String query;
  const TvSearchOnQueryChangeEvent(this.query);

}
