part of 'tv_detail_bloc.dart';

sealed class TvDetailEvent {
  
}

class TvDetailFetch extends TvDetailEvent {
  final int id;

  TvDetailFetch(this.id);
}