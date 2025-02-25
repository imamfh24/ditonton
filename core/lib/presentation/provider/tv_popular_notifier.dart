import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import 'package:flutter/material.dart';

import '../../domain/usecases/get_tv_popular.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetTvPopular getTvPopular;
  TvPopularNotifier({
    required this.getTvPopular,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tvPopular = [];
  List<Tv> get tvPopular => _tvPopular;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvPopular() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _state = RequestState.loaded;
        _tvPopular = data;
      },
    );
    notifyListeners();
  }
}
