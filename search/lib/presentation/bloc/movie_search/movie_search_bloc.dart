import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/utils/debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';

part 'movie_search_event.dart';
part 'movie_search_state.dart';

class MovieSearchBloc extends Bloc<MovieSearchEvent, MovieSearchState> {
  final SearchMovies _searchMovies;
  MovieSearchBloc(this._searchMovies) : super(MovieSearchEmpty()) {
    on<MovieSearchOnQueryChangeEvent>((event, emit) async {
      final query = event.query;
      emit(MovieSearchLoading());

      final result = await _searchMovies.execute(query);

      result.fold(
        (failure) {
          emit(MovieSearchError('Error'));
        },
        (data) {
          if (data.isEmpty) {
            emit(MovieSearchEmpty());
            return;
          }
          emit(MovieSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
