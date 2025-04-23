import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/usecases/movies/get_popular_movies.dart';
import 'package:equatable/equatable.dart';

part 'movie_popular_event.dart';
part 'movie_popular_state.dart';

class MoviePopularBloc extends Bloc<MoviePopularEvent, MoviePopularState> {
  final GetPopularMovies getPopularMovies;
  MoviePopularBloc(this.getPopularMovies) : super(MoviePopularInitial()) {
    on<MoviePopularFetch>(_moviePopularFetch);
  }

  Future<void> _moviePopularFetch(event, emit) async{
    emit(MoviePopularLoading());

    final result = await getPopularMovies.execute();

    result.fold(
      (failure) {
        emit(MoviePopularError(failure.message));
      },
      (data) {
        emit(MoviePopularHasData(data));
      },
    );
  }
}
