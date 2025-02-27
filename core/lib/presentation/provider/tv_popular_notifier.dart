import 'package:core/utils/state_enum.dart';
import 'package:core/domain/entities/tv.dart';
import 'package:flutter/material.dart';

import 'package:core/domain/usecases/get_tv_popular.dart';

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
        _tvPopular = data
            .where((item) =>
                item.backdropPath != null &&
                (item.overview != null && item.overview!.isNotEmpty))
            .toList();

        if (_tvPopular.isEmpty) {
          _state = RequestState.error;
          _message = "Tidak ada data";
        } else {
          _state = RequestState.loaded;
        }
      },
    );
    notifyListeners();
  }
}
