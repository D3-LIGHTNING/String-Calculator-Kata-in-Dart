import 'package:string_calculator/delimiter_provider.dart';
import 'calculator_engine.dart';

class NumberParser {
  final List<DelimiterProvider> _delimiterProviders;

  const NumberParser({required List<DelimiterProvider> delimiterProviders})
      : _delimiterProviders = delimiterProviders;

  ParsedNumbersOutput parseNumbers(String input) {
    List<String> delimiters = [];
    String numbersString = input;

    for (DelimiterProvider provider in _delimiterProviders) {
      List<String> dl = provider.getDelimitersFromInput(numbersString);

      delimiters.addAll(dl);

      if (provider is CustomDelimiterProvider &&
          provider.canHandleInput(numbersString)) {
        numbersString =
            numbersString.substring(numbersString.indexOf('\n') + 1);
      }
    }

    RegExp regExp = RegExp(delimiters.map(RegExp.escape).join("|"));

    List<String> numbers = numbersString.split(regExp)
      ..removeWhere((element) => element.isEmpty);

    return ParsedNumbersOutput(
        numbers: List.from(numbers.map(int.parse)),
        engine: getEngine(delimiters));
  }

  CalculatorEngine getEngine(List<String> delimiters) {
    if (delimiters.contains("*")) {
      return CalculatorMultiplyEngine();
    }
    return CalculatorAddEngine();
  }
}

class ParsedNumbersOutput {
  final List<int> numbers;
  final CalculatorEngine engine;

  const ParsedNumbersOutput({required this.numbers, required this.engine});

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ParsedNumbersOutput) return false;

    if (numbers.length != other.numbers.length) return false;

    for (int i = 0; i < numbers.length; i++) {
      if (numbers[i] != other.numbers[i]) return false;
    }

    return true;
  }
}
