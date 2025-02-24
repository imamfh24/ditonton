import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_popular.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';

class TvListNotifier extends ChangeNotifier {
  final GetTvAiringToday getTvAiringToday;
  final GetTvPopular getTvPopular;
  final GetTvTopRated getTvTopRated;
  TvListNotifier(
      {required this.getTvAiringToday,
      required this.getTvPopular,
      required this.getTvTopRated});

  RequestState _tvAiringState = RequestState.Empty;
  RequestState get tvAiringState => this._tvAiringState;
  List<Tv> _tvAiringToday = [];
  List<Tv> get tvAiringToday => this._tvAiringToday;

  RequestState _tvPopularState = RequestState.Empty;
  RequestState get tvPopularState => this._tvPopularState;
  List<Tv> _tvPopular = [];
  List<Tv> get tvPopular => this._tvPopular;

  RequestState _tvTopRatedState = RequestState.Empty;
  RequestState get tvTopRatedState => this._tvTopRatedState;
  List<Tv> _tvTopRated = [];
  List<Tv> get tvTopRated => this._tvTopRated;

  String _message = '';
  String get message => _message;

  Future<void> fetchTvAiringToday() async {
    _tvAiringState = RequestState.Loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold(
      (failure) {
        _tvAiringState = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _tvAiringState = RequestState.Loaded;
        _tvAiringToday = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchTvTopRated() async {
    _tvTopRatedState = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _tvTopRatedState = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _tvTopRatedState = RequestState.Loaded;
        _tvTopRated = data;
      },
    );
    notifyListeners();
  }

  Future<void> fetchTvPopular() async {
    _tvPopularState = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _tvPopularState = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _tvPopularState = RequestState.Loaded;
        _tvPopular = data;
      },
    );
    notifyListeners();
  }
}
