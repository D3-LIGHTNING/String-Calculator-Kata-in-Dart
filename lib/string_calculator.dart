int add(String numbers) {
  if (numbers.isEmpty) return 0;

  RegExp regExp = RegExp(r'[,\n]');

  List<String> numberList = numbers.split(regExp);
  int sumOfNumbers = 0;

  for (String number in numberList) {
    sumOfNumbers += int.parse(number);
  }

  return sumOfNumbers;
}
