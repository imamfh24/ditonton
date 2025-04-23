import 'package:core/utils/encrypt.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Encryption Tests', () {
    test('should return a non-empty encrypted string', () {
      const plainText = 'Hello, World!';
      final encryptedText = encrypt(plainText);

      expect(encryptedText, isNotEmpty);
    });

    test('should return different encrypted strings for different inputs', () {
      const plainText1 = 'Hello, World!';
      const plainText2 = 'Goodbye, World!';
      final encryptedText1 = encrypt(plainText1);
      final encryptedText2 = encrypt(plainText2);

      expect(encryptedText1, isNot(equals(encryptedText2)));
    });

    test('should return the same encrypted string for the same input', () {
      const plainText = 'Hello, World!';
      final encryptedText1 = encrypt(plainText);
      final encryptedText2 = encrypt(plainText);

      expect(encryptedText1, equals(encryptedText2));
    });
  });
}