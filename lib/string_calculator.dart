int add(String numbers) {
  if (numbers.isEmpty) return 0;

  int sumOfNumbers = 0;
  List<String> numberList = numbers.split(",");

  for (String number in numberList) {
    sumOfNumbers += int.parse(number);
  }

  return sumOfNumbers;
}
