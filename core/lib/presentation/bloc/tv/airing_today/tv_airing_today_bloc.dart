import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_airing_today.dart';
import 'package:equatable/equatable.dart';

part 'tv_airing_today_event.dart';
part 'tv_airing_today_state.dart';

class TvAiringTodayBloc extends Bloc<TvAiringTodayEvent, TvAiringTodayState> {
  GetTvAiringToday getTvAiringToday;
  TvAiringTodayBloc(this.getTvAiringToday) : super(TvAiringTodayInitial()) {
    on<TvAiringTodayFetch>(_fetchTvAiringToday);
  }

  Future<void> _fetchTvAiringToday(
      TvAiringTodayFetch event, Emitter<TvAiringTodayState> emit) async {
    emit(TvAiringTodayLoading());

    final result = await getTvAiringToday.execute();

    result.fold(
      (failure) {
        emit(TvAiringTodayError(failure.message));
      },
      (data) {
        emit(TvAiringTodayHasData(data));
      },
    );
  }
}
