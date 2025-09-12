int add(String numbers) {
  if (numbers.isEmpty) return 0;

  List<String> delimiters = [',', '\n'];

  bool multiply = false;

  if (numbers.startsWith("//")) {
    String delimiter = numbers.substring(2, numbers.indexOf('\n'));

    if (delimiter.startsWith("[") && delimiter.endsWith("]")) {
      String customDelimiter = delimiter.substring(1, delimiter.length - 1);
      delimiters.add(customDelimiter);
    } else {
      multiply = delimiter == "*";
      delimiters.add(delimiter);
    }

    numbers = numbers.substring(numbers.indexOf('\n') + 1);
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
