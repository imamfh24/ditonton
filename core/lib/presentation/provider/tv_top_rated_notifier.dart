import 'package:core/core.dart';
import '../../domain/entities/tv.dart';
import '../../domain/usecases/get_tv_top_rated.dart';
import 'package:flutter/material.dart';

class TvTopRatedNotifier extends ChangeNotifier {
  final GetTvTopRated getTvTopRated;
  TvTopRatedNotifier({
    required this.getTvTopRated,
  });

  RequestState _state = RequestState.empty;
  RequestState get state => _state;
  List<Tv> _tvTopRated = [];
  List<Tv> get tvTopRated => _tvTopRated;
  String _message = '';
  String get message => _message;

  Future<void> fetchTvTopRated() async {
    _state = RequestState.loading;
    notifyListeners();

    final result = await getTvTopRated.execute();
    result.fold(
      (failure) {
        _state = RequestState.error;
        _message = failure.message;
      },
      (data) {
        _state = RequestState.loaded;
        _tvTopRated = data;
      },
    );
    notifyListeners();
  }
}
