import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/tv/get_tv_popular.dart';
import 'package:equatable/equatable.dart';

part 'tv_popular_event.dart';
part 'tv_popular_state.dart';

class TvPopularBloc extends Bloc<TvPopularEvent, TvPopularState> {
  GetTvPopular getTvPopular;
  TvPopularBloc(this.getTvPopular) : super(TvPopularInitial()) {
    on<TvPopularFetch>(_fetchTvPopular);
  }
  Future<void> _fetchTvPopular(
      TvPopularFetch event, Emitter<TvPopularState> emit) async {
    emit(TvPopularLoading());

    final result = await getTvPopular.execute();

    result.fold(
      (failure) {
        emit(TvPopularError(failure.message));
      },
      (data) {
        emit(TvPopularHasData(data));
      },
    );
  }
}
