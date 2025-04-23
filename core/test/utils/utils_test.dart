import 'package:core/utils/utils.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('routeObserver should be an instance of RouteObserver<ModalRoute>', () {
    expect(routeObserver, isA<RouteObserver<ModalRoute>>());
  });
}