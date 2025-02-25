import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_popular.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_airing_today.dart';

class TvListNotifier extends ChangeNotifier {
  final GetTvAiringToday getTvAiringToday;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;
  TvListNotifier(
      {required this.getTvAiringToday,
      required this.getTvPopular,
      required this.getTvTopRated});

  RequestState _tvAiringState = RequestState.empty;
  RequestState get tvAiringState => _tvAiringState;
  List<Tv> _tvAiringToday = [];
  List<Tv> get tvAiringToday => _tvAiringToday;

  RequestState _tvPopularState = RequestState.empty;
  RequestState get tvPopularState => _tvPopularState;
  List<Tv> _tvPopular = [];
  List<Tv> get tvPopular => _tvPopular;

  RequestState _tvTopRatedState = RequestState.empty;
  RequestState get tvTopRatedState => _tvTopRatedState;
  List<Tv> _tvTopRated = [];
  List<Tv> get tvTopRated => _tvTopRated;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvAiringToday() async {
    _tvAiringState = RequestState.loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold(
      (failure) {
        _tvAiringState = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _tvAiringState = RequestState.loaded;
        _tvAiringToday = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchTvTopRated() async {
    _tvTopRatedState = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _tvTopRatedState = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _tvTopRatedState = RequestState.loaded;
        _tvTopRated = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchTvPopular() async {
    _tvPopularState = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _tvPopularState = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _tvPopularState = RequestState.loaded;
        _tvPopular = data;
      },
    );
    notifyListeners();
  }
}
