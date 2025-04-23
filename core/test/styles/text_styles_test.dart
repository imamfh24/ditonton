import 'package:core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  group('Text Styles', () {
    test('kHeading5 should have correct font size and weight', () {
      expect(kHeading5.fontSize, 23);
      expect(kHeading5.fontWeight, FontWeight.w400);
    });

    test('kHeading6 should have correct font size, weight, and letter spacing', () {
      expect(kHeading6.fontSize, 19);
      expect(kHeading6.fontWeight, FontWeight.w500);
      expect(kHeading6.letterSpacing, 0.15);
    });

    test('kSubtitle should have correct font size, weight, and letter spacing', () {
      expect(kSubtitle.fontSize, 15);
      expect(kSubtitle.fontWeight, FontWeight.w400);
      expect(kSubtitle.letterSpacing, 0.15);
    });

    test('kBodyText should have correct font size, weight, and letter spacing', () {
      expect(kBodyText.fontSize, 13);
      expect(kBodyText.fontWeight, FontWeight.w400);
      expect(kBodyText.letterSpacing, 0.25);
    });

    test('kTextTheme should have correct text styles', () {
      expect(kTextTheme.headlineMedium, kHeading5);
      expect(kTextTheme.headlineSmall, kHeading6);
      expect(kTextTheme.labelMedium, kSubtitle);
      expect(kTextTheme.bodyMedium, kBodyText);
    });
  });
}