import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:core/domain/usecases/movies/get_movie_detail.dart';
import 'package:equatable/equatable.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {

  final GetMovieDetail getMovieDetail;
  MovieDetailBloc(
    this.getMovieDetail,
  ) : super(MovieDetailInitial()) {
    on<MovieDetailFetch>(_movieDetailFetch);
  }

  Future<void> _movieDetailFetch(
      MovieDetailFetch event, Emitter<MovieDetailState> emit) async {
    emit(MovieDetailLoading());

    final result = await getMovieDetail.execute(event.id);

    result.fold(
      (failure) {
        emit(MovieDetailError(failure.message));
      },
      (detail) {
        emit(MovieDetailHasData(detail));
      },
    );
  }
}
