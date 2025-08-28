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
  int sumOfNumbers = 0;

  for (String number in numberList) {
    sumOfNumbers += int.parse(number);
  }

  return sumOfNumbers;
}
