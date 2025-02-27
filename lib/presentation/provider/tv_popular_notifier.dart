import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:flutter/material.dart';

import 'package:ditonton/domain/usecases/get_tv_popular.dart';

class TvPopularNotifier extends ChangeNotifier {
  final GetTvPopular getTvPopular;
  TvPopularNotifier({
    required this.getTvPopular,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => this._state;
  List<Tv> _tvPopular = [];
  List<Tv> get tvPopular => this._tvPopular;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvPopular() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvPopular.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _tvPopular = data
            .where((item) =>
                item.backdropPath != null &&
                (item.overview != null && item.overview!.isNotEmpty))
            .toList();

        if (_tvPopular.isEmpty) {
          _state = RequestState.Error;
          _message = "Tidak ada data";
        } else {
          _state = RequestState.Loaded;
        }
      },
    );
    notifyListeners();
  }
}
