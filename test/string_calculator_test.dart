import 'package:string_calculator/delimiter_provider.dart';
import 'package:string_calculator/number_parser.dart';
import 'package:string_calculator/string_calculator.dart';
import 'package:test/test.dart';

void main() {
  group('String Calculator step 1', () {
    test('returns 0 when input is empty string', () {
      StringCalculator calculator = StringCalculator(
          numberParser:
              NumberParser(delimiterProviders: [DefaultDelimiterProvider()]));
      expect(calculator.calculate(''), equals(0));
    });

    test('returns the number itself when input is a single number', () {
      StringCalculator calculator = StringCalculator(
          numberParser:
              NumberParser(delimiterProviders: [DefaultDelimiterProvider()]));
      expect(calculator.calculate('5'), equals(5));
      expect(calculator.calculate('42'), equals(42));
    });

    test('returns the sum when input has two numbers separated by comma', () {
      StringCalculator calculator = StringCalculator(
          numberParser:
              NumberParser(delimiterProviders: [DefaultDelimiterProvider()]));
      expect(calculator.calculate('1,2'), equals(3));
      expect(calculator.calculate('10,20'), equals(30));
    });
  });

  group('String Calculator step 2', () {
    test("returns the sume of multiple numbers separated by commas", () {
      StringCalculator calculator = StringCalculator(
          numberParser:
              NumberParser(delimiterProviders: [DefaultDelimiterProvider()]));
      expect(calculator.calculate('1,2,3,4,5'), equals(15));
      expect(calculator.calculate('10,20,30,40'), equals(100));
    });
  });

  group('String Calculator step 3', () {
    test("handles new lines along with commas as separators", () {
      StringCalculator calculator = StringCalculator(
          numberParser:
              NumberParser(delimiterProviders: [DefaultDelimiterProvider()]));
      expect(calculator.calculate('1\n2,3'), equals(6));
      expect(calculator.calculate('10\n20\n30,40'), equals(100));
    });
  });

  group('String Calculator step 4', () {
    test("handles new custom delimiters in addition to comma and \n", () {
      StringCalculator calculator = StringCalculator(
          numberParser: NumberParser(delimiterProviders: [
        DefaultDelimiterProvider(),
        CustomDelimiterProvider()
      ]));
      expect(calculator.calculate("//;\n1;2"), equals(3));
      expect(calculator.calculate("//|\n10|20,30"), equals(60));
      expect(calculator.calculate("//|\n10|20,30\n40"), equals(100));
    });
  });

  group('String Calculator step 5', () {
    test("Throws Exception when negative numbers are passed", () {
      StringCalculator calculator = StringCalculator(
          numberParser: NumberParser(delimiterProviders: [
        DefaultDelimiterProvider(),
        CustomDelimiterProvider()
      ]));
      expect(
        () => calculator.calculate("-1,2,-3"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -1, -3"))),
      );

      expect(
        () => calculator.calculate("10,-20,30\n40"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -20"))),
      );

      expect(
        () => calculator.calculate("//;\n1,2\n-3"),
        throwsA(predicate((e) =>
            e is Exception &&
            e.toString().contains("negative numbers not allowed: -3"))),
      );
    });
  });

  group('String Calculator step 6', () {
    test("Numbers grater than 1000 will not be added", () {
      StringCalculator calculator = StringCalculator(
          numberParser: NumberParser(delimiterProviders: [
        DefaultDelimiterProvider(),
        CustomDelimiterProvider()
      ]));
      expect(calculator.calculate("2,1001\n100"), equals(102));
      expect(calculator.calculate("1000,1001\n1002,3"), equals(1003));
    });
  });

  group('String Calculator step 7', () {
    test("Allows delimitters of any length to be accepted as Separator", () {
      StringCalculator calculator = StringCalculator(
          numberParser: NumberParser(delimiterProviders: [
        DefaultDelimiterProvider(),
        CustomDelimiterProvider()
      ]));
      expect(calculator.calculate("//[***]\n1***2***3"), equals(6));
      expect(calculator.calculate("//[&&]\n1&&2&&3,4\n5"), equals(15));
    });
  });

  group('String Calculator step 8', () {
    test(
        "If the custom delmiters is * then the numbers in between will be multiplied",
        () {
      StringCalculator calculator = StringCalculator(
          numberParser: NumberParser(delimiterProviders: [
        DefaultDelimiterProvider(),
        CustomDelimiterProvider()
      ]));
      expect(calculator.calculate("//*\n10*1*2"), equals(20));
    });

    group(
      'String Calculator step 9, Delimiters - [SOLID PRINCIPLES]',
      () {
        test(
          "The default delimiter should return a list of preset delimiters",
          () {
            DelimiterProvider provider = DefaultDelimiterProvider();
            expect(provider.getDelimitersFromInput("1\n2,3"), [',', '\n']);
          },
        );

        test(
          "The custom delimiter provider should return deimiters that appear after //",
          () {
            DelimiterProvider provider = CustomDelimiterProvider();
            expect(provider.getDelimitersFromInput("//;\n1;2"), [';']);
          },
        );
      },
    );

    group(
      'String Calculator step 10, Number parser - [SOLID PRINCIPLES]',
      () {
        test(
          "Number parser should return the list of numbers in string format",
          () {
            NumberParser parser = NumberParser(delimiterProviders: [
              DefaultDelimiterProvider(),
              CustomDelimiterProvider()
            ]);
            expect(
              parser.parseNumbers("1\n2,3"),
              predicate<ParsedNumbersOutput>(
                (o) =>
                    o.numbers.join(",") == ["1", "2", "3"].join(",") &&
                    o.multiply == false,
              ),
            );
          },
        );
      },
    );
  });
}
