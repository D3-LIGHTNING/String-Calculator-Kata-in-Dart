import 'package:string_calculator/number_parser.dart';

class StringCalculator {
  final NumberParser numberParser;

  const StringCalculator({required this.numberParser});

  int calculate(String numbers) {
    if (numbers.isEmpty) return 0;

    ParsedNumbersOutput parsedOutput = numberParser.parseNumbers(numbers);
    List<String> numberList = parsedOutput.numbers;
    bool multiply = parsedOutput.multiply;

    List<String> negativeNumbers = [];
    int sumOfNumbers = multiply ? 1 : 0;

    for (String number in numberList) {
      if (number.isEmpty) continue;

      int parsedNumber = int.parse(number);

      if (parsedNumber < 0) {
        negativeNumbers.add(number);
        continue;
      }

      if (parsedNumber > 1000) continue;

      sumOfNumbers =
          multiply ? sumOfNumbers * parsedNumber : sumOfNumbers + parsedNumber;
    }

    if (negativeNumbers.isNotEmpty) {
      throw Exception(
          "negative numbers not allowed: ${negativeNumbers.join(", ")}");
    }

    return sumOfNumbers;
  }
}
