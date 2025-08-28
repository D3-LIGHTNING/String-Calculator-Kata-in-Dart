import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('String Calculator step 1', () {
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

  group('String Calculator step 2', () {
    test("returns the sume of multiple numbers separated by commas", () {
      expect(add('1,2,3,4,5'), equals(15));
      expect(add('10,20,30,40'), equals(100));
    });
  });

  group('String Calculator step 3', () {
    test("handles new lines along with commas as separators", () {
      expect(add('1\n2,3'), equals(6));
      expect(add('10\n20\n30,40'), equals(100));
    });
  });

  group('String Calculator step 4', () {
    test("handles new custom delimiters in addition to comma and \n", () {
      expect(add("//;\n1;2"), equals(3));
      expect(add("//|\n10|20,30"), equals(60));
      expect(add("//|\n10|20,30\n40"), equals(100));
    });
  });

  group('String Calculator step 5', () {
    test("Throws Exception when negative numbers are passed", () {
      expect(
        () => add("-1,2,-3"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -1, -3"))),
      );

      expect(
        () => add("10,-20,30\n40"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -20"))),
      );

      expect(
        () => add("//;\n1,2\n-3"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -3"))),
      );
    });
  });
}
