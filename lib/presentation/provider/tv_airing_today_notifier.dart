import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter/material.dart';

class TvAiringTodayNotifier extends ChangeNotifier {
  final GetTvAiringToday getTvAiringToday;
  TvAiringTodayNotifier({
    required this.getTvAiringToday,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => this._state;
  List<Tv> _tvAiringToday = [];
  List<Tv> get tvAiringToday => this._tvAiringToday;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvAiringToday() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _state = RequestState.Loaded;
        _tvAiringToday = data;
      },
    );
    notifyListeners();
  }
}
