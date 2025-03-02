part of 'search_bloc.dart';

sealed class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class OnQueryChangeEvent extends SearchEvent {
  final String query;
  final WatchType watchType;
  const OnQueryChangeEvent(this.query, this.watchType);

  @override
  List<Object?> get props => [query, watchType];
}
