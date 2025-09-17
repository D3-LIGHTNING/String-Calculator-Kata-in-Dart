import 'package:string_calculator/number_parser.dart';

class StringCalculator {
  final NumberParser numberParser;

  StringCalculator({required this.numberParser});

  int calculate(String numbers) {
    if (numbers.isEmpty) return 0;

    ParsedNumbersOutput parsedOutput = numberParser.parseNumbers(numbers);

    return parsedOutput.engine.calculate(parsedOutput.numbers);
  }
}
