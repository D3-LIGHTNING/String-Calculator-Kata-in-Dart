import 'package:string_calculator/delimiter_provider.dart';

class NumberParser {
  final List<DelimiterProvider> _delimiterProviders;

  const NumberParser({required List<DelimiterProvider> delimiterProviders})
      : _delimiterProviders = delimiterProviders;

  ParsedNumbersOutput parseNumbers(String input) {
    List<String> delimiters = [];
    String numbersString = input;
    bool multiply = false;

    for (DelimiterProvider provider in _delimiterProviders) {
      List<String> dl = provider.getDelimitersFromInput(input);

      delimiters.addAll(dl);

      if (provider is CustomDelimiterProvider &&
          provider.canHandleInput(input)) {
        numbersString =
            numbersString.substring(numbersString.indexOf('\n') + 1);
        multiply = dl.contains("*");
      }
    }
    RegExp regExp = RegExp(delimiters.map(RegExp.escape).join("|"));
    List<String> numbers = numbersString.split(regExp);

    return ParsedNumbersOutput(numbers: numbers, multiply: multiply);
  }
}

class ParsedNumbersOutput {
  final List<String> numbers;
  final bool multiply;

  const ParsedNumbersOutput({required this.numbers, required this.multiply});
}
