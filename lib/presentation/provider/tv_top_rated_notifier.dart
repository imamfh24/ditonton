import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv.dart';
import 'package:ditonton/domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;
  TvTopRatedNotifier({
    required this.getTvTopRated,
  });

  RequestState _state = RequestState.Empty;
  RequestState get state => this._state;
  List<Tv> _tvTopRated = [];
  List<Tv> get tvTopRated => this._tvTopRated;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvTopRated() async {
    _state = RequestState.Loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _state = RequestState.Error;
        _message = failure.message;
      },
      (data) {
        _state = RequestState.Loaded;
        _tvTopRated = data;
      },
    );
    notifyListeners();
  }
}
