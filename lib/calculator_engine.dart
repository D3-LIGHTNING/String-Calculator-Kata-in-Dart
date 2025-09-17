import 'package:string_calculator/number_parser.dart';

class CalculatorEngine {
  int calculate(ParsedNumbersOutput numbersOutput) {
    List<String> negativeNumbers = [];
    int sumOfNumbers = numbersOutput.multiply ? 1 : 0;

    for (String number in numbersOutput.numbers) {
      if (number.isEmpty) continue;

      int parsedNumber = int.parse(number);

      if (parsedNumber < 0) {
        negativeNumbers.add(number);
        continue;
      }

      if (parsedNumber > 1000) continue;

      sumOfNumbers = numbersOutput.multiply
          ? sumOfNumbers * parsedNumber
          : sumOfNumbers + parsedNumber;
    }

    if (negativeNumbers.isNotEmpty) {
      throw Exception(
          "negative numbers not allowed: ${negativeNumbers.join(", ")}");
    }

    return sumOfNumbers;
  }
}
