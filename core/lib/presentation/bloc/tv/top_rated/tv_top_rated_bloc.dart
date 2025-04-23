import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/tv/get_tv_top_rated.dart';
import 'package:equatable/equatable.dart';

part 'tv_top_rated_event.dart';
part 'tv_top_rated_state.dart';

class TvTopRatedBloc extends Bloc<TvTopRatedEvent, TvTopRatedState> {
  GetTvTopRated getTvTopRated;
  TvTopRatedBloc(this.getTvTopRated) : super(TvTopRatedInitial()) {
    on<TvTopRatedFetch>(_fetchTvTopRated);
  }

  Future<void> _fetchTvTopRated(
      TvTopRatedFetch event, Emitter<TvTopRatedState> emit) async {
    emit(TvTopRatedLoading());

    final result = await getTvTopRated.execute();

    result.fold(
      (failure) {
        emit(TvTopRatedError(failure.message));
      },
      (data) {
        emit(TvTopRatedHasData(data));
      },
    );
  }
}
