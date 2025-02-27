import 'package:core/utils/state_enum.dart';

import 'package:core/domain/entities/tv.dart';
import 'package:core/domain/usecases/get_tv_airing_today.dart';
import 'package:flutter/material.dart';

class TvAiringTodayNotifier extends ChangeNotifier {
  final GetTvAiringToday getTvAiringToday;
  TvAiringTodayNotifier({
    required this.getTvAiringToday,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tvAiringToday = [];
  List<Tv> get tvAiringToday => _tvAiringToday;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvAiringToday() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvAiringToday.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _state = RequestState.loaded;
        _tvAiringToday = data;
      },
    );
    notifyListeners();
  }
}
