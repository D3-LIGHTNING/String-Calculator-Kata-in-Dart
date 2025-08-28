int add(String numbers) {
  if (numbers.isEmpty) return 0;

  List<String> delimiters = [',', '\n'];

  if (numbers.startsWith("//")) {
    String delimiter = numbers.substring(2, numbers.indexOf('\n'));
    delimiters.add(delimiter);
    numbers = numbers.substring(numbers.indexOf('\n') + 1);
  }

  RegExp regExp = RegExp(delimiters.map(RegExp.escape).join("|"));

  List<String> numberList = numbers.split(regExp);
  List<String> negativeNumbers = [];
  int sumOfNumbers = 0;

  for (String number in numberList) {
    if (number.isEmpty) continue;

    int parsedNumber = int.parse(number);

    if (parsedNumber < 0) {
      negativeNumbers.add(number);
      continue;
    }

    sumOfNumbers += parsedNumber;
  }

  if (negativeNumbers.isNotEmpty) {
    throw Exception(
        "negative numbers not allowed: ${negativeNumbers.join(", ")}");
  }

  return sumOfNumbers;
}
