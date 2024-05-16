extension StringExtension on String {
  String replaceSpaceWithNewLine() {
    return replaceAll(' ', '\n');
  }

  String replaceLast(String from, String to) {
    int lastIndex = lastIndexOf(from);
    if (lastIndex == -1) {
      return this;
    }
    String before = substring(0, lastIndex);
    String after = substring(lastIndex + from.length);
    return before + to + after;
  }
}
