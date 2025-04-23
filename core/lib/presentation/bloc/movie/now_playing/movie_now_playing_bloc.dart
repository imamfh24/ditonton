import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_now_playing_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_now_playing_event.dart';
part 'movie_now_playing_state.dart';

class MovieNowPlayingBloc extends Bloc<MovieNowPlayingEvent, MovieNowPlayingState> {
  final GetNowPlayingMovies getNowPlayingMovies;
  MovieNowPlayingBloc(this.getNowPlayingMovies)
      : super(MovieNowPlayingInitial()) {
    on<MovieNowPlayingFetch>(_fetchNowPlayingMovies);
  }

  Future<void> _fetchNowPlayingMovies(MovieNowPlayingFetch event,
      Emitter<MovieNowPlayingState> emit) async {
    emit(MovieNowPlayingLoading());
    final result = await getNowPlayingMovies.execute();
    result.fold(
      (failure) => emit(MovieNowPlayingError(failure.message)),
      (data) => emit(MovieNowPlayingHasData(data)),
    );
  }
}
