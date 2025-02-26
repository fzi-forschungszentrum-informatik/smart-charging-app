class DateTimeUtil {
  static final DateTime _minDate = DateTime.fromMillisecondsSinceEpoch(0);

  static DateTime parseJavaDate(String str) {
    return str == "-1000000000-01-01T00:00:00Z"
        ? _minDate
        : DateTime.parse(str);
  }
}
