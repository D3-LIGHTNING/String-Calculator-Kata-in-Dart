import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('String Calculator', () {
    test('returns 0 when input is empty string', () {
      expect(add(''), equals(0));
    });

    test('returns the number itself when input is a single number', () {
      expect(add('5'), equals(5));
      expect(add('42'), equals(42));
    });

    test('returns the sum when input has two numbers separated by comma', () {
      expect(add('1,2'), equals(3));
      expect(add('10,20'), equals(30));
    });
  });
}
