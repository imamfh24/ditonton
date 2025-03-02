import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/debounce.dart';
import 'package:core/utils/watch_type.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  final SearchMovies _searchMovies;
  final SearchTv _searchTv;
  SearchBloc(this._searchMovies, this._searchTv) : super(SearchEmpty()) {
    on<OnQueryChangeEvent>((event, emit) async {
      final query = event.query;
      final type = event.watchType;
      emit(SearchLoading());

      final result = type == WatchType.movie
          ? await _searchMovies.execute(query)
          : await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(SearchError('Error'));
        },
        (data) {
          if (type == WatchType.movie) {
            emit(SearchHasData<Movie>(data as List<Movie>));
          } else {
            emit(SearchHasData<Tv>(data as List<Tv>));
          }
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
