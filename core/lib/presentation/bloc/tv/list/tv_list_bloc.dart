import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_airing_today.dart';
import 'package:core/domain/usecases/get_tv_popular.dart';
import 'package:core/domain/usecases/get_tv_top_rated.dart';
import 'package:equatable/equatable.dart';

part 'tv_list_event.dart';
part 'tv_list_state.dart';

class TvListBloc extends Bloc<TvListEvent, TvListState> {
  final GetTvAiringToday getTvAiringToday;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;
  TvListBloc(
    this.getTvAiringToday,
    this.getTvPopular,
    this.getTvTopRated,
  ) : super(TvListInitial()) {
    on<TvListFetchAiringToday>(_fetchTvAiringToday);
    on<TvListFetchPopular>(_fetchTvPopular);
    on<TvListFetchTopRated>(_fetchTvTopRated);
  }

    Future<void> _fetchTvAiringToday(TvListFetchAiringToday event,
      Emitter<TvListState> emit) async {
    emit(TvListAiringTodayLoading());

    final result = await getTvAiringToday.execute();

    result.fold(
      (failure) {
        emit(TvListAiringTodayError(failure.message));
      },
      (data) {
        emit(TvListAiringTodayHasData(data));
      },
    );
  }

  Future<void> _fetchTvPopular(TvListFetchPopular event,
      Emitter<TvListState> emit) async {
    emit(TvListPopularLoading());

    final result = await getTvPopular.execute();

    result.fold(
      (failure) {
        emit(TvListPopularError(failure.message));
      },
      (data) {
        emit(TvListPopularHasData(data));
      },
    );
  }

  Future<void> _fetchTvTopRated(TvListFetchTopRated event,
      Emitter<TvListState> emit) async {
    emit(TvListTopRatedLoading());

    final result = await getTvTopRated.execute();

    result.fold(
      (failure) {
        emit(TvListTopRatedError(failure.message));
      },
      (data) {
        emit(TvListTopRatedHasData(data));
      },
    );
  }
}
