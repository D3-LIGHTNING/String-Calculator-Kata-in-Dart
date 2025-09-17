abstract class CalculatorEngine {
  int calculate(List<int> numbers);
}

class CalculatorAddEngine extends CalculatorEngine {
  @override
  int calculate(List<int> numbers) {
    List<int> negativeNumbers = [];
    int sumOfNumbers = 0;

    for (int number in numbers) {
      if (number < 0) {
        negativeNumbers.add(number);
        continue;
      }

      if (number > 1000) continue;

      sumOfNumbers += number;
    }

    _validateNonNegativeNumbers(negativeNumbers);

    return sumOfNumbers;
  }

  void _validateNonNegativeNumbers(List<int> numbers) {
    if (numbers.isNotEmpty) {
      throw Exception("negative numbers not allowed: ${numbers.join(", ")}");
    }
  }
}

class CalculatorMultiplyEngine extends CalculatorEngine {
  @override
  int calculate(List<int> numbers) {
    List<int> negativeNumbers = [];
    int productOfNumbers = 1;

    for (int number in numbers) {
      if (number < 0) {
        negativeNumbers.add(number);
        continue;
      }

      if (number > 1000) continue;

      productOfNumbers *= number;
    }

    _validateNonNegativeNumbers(negativeNumbers);

    return productOfNumbers;
  }

  void _validateNonNegativeNumbers(List<int> numbers) {
    if (numbers.isNotEmpty) {
      throw Exception("negative numbers not allowed: ${numbers.join(", ")}");
    }
  }
}
