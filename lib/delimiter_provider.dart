abstract class DelimiterProvider {
  bool canHandleInput(String input);

  List<String> getDelimitersFromInput(String input);
}

class DefaultDelimiterProvider implements DelimiterProvider {
  @override
  List<String> getDelimitersFromInput(String input) => [',', '\n'];

  @override
  bool canHandleInput(String input) => true;
}

class CustomDelimiterProvider implements DelimiterProvider {
  @override
  List<String> getDelimitersFromInput(String input) {
    List<String> delimiters = [];
    if (canHandleInput(input)) {
      String delimiter = input.substring(2, input.indexOf('\n'));

      if (delimiter.startsWith("[") && delimiter.endsWith("]")) {
        String customDelimiter = delimiter.substring(1, delimiter.length - 1);
        delimiters.add(customDelimiter);
      } else {
        delimiters.add(delimiter);
      }
    }

    return delimiters;
  }

  @override
  bool canHandleInput(String input) => input.startsWith("//");
}
