import 'package:string_calculator/delimiter_provider.dart';

class StringCalculator {
  final List<DelimiterProvider> delimiterProviders;

  const StringCalculator({required this.delimiterProviders});

  int calculate(String numbers) {
    if (numbers.isEmpty) return 0;

    List<String> delimiters = [];

    bool multiply = false;

    for (DelimiterProvider provider in delimiterProviders) {
      List<String> dl = provider.getDelimitersFromInput(numbers);

      delimiters.addAll(dl);

      if (provider is CustomDelimiterProvider &&
          provider.canHandleInput(numbers)) {
        numbers = numbers.substring(numbers.indexOf('\n') + 1);
        multiply = dl.contains("*");
      }
    }

    RegExp regExp = RegExp(delimiters.map(RegExp.escape).join("|"));

    List<String> numberList = numbers.split(regExp);
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
