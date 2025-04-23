import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/utils/debounce.dart';
import 'package:equatable/equatable.dart';
import 'package:search/search.dart';

part 'tv_search_event.dart';
part 'tv_search_state.dart';

class TvSearchBloc extends Bloc<TvSearchEvent, TvSearchState> {
  final SearchTv _searchTv;
  TvSearchBloc(this._searchTv) : super(TvSearchEmpty()) {
    on<TvSearchOnQueryChangeEvent>((event, emit) async {
      final query = event.query;
      emit(TvSearchLoading());

      final result = await _searchTv.execute(query);

      result.fold(
        (failure) {
          emit(TvSearchError('Error'));
        },
        (data) {
            emit(TvSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
