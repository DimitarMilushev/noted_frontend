class HtmlContentHelper {
  static RegExp tagMatcher = RegExp(r'<(.+?)>');
  static RegExp spaceMatcher = RegExp(r'&nbsp');

  /// Returns HTML content as plain text
  static String convertToPlainText(String html) {
    return html.replaceAll(tagMatcher, "").replaceAll(spaceMatcher, " ");
  }
}
