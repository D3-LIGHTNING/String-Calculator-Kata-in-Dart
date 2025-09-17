import 'package:string_calculator/calculator_engine.dart';
import 'package:string_calculator/number_parser.dart';

class StringCalculator {
  final NumberParser numberParser;
  final CalculatorEngine _engine;

  StringCalculator({required this.numberParser}) : _engine = CalculatorEngine();

  int calculate(String numbers) {
    if (numbers.isEmpty) return 0;

    ParsedNumbersOutput parsedOutput = numberParser.parseNumbers(numbers);

    return _engine.calculate(parsedOutput);
  }
}
