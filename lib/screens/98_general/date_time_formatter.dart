import 'package:intl/intl.dart';

class Formatter {

  static String returnFormatHHmm(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  static String returnFormatdMYHHmm(DateTime dateTime) {
    return DateFormat('dd.MM HH:mm').format(dateTime);
  }

  static String returnFormatddMMMM(DateTime dateTime) {
    return DateFormat('dd.MMMM').format(dateTime);
  }

  static String returnFormatMMMMd(DateTime dateTime) {
    return DateFormat.MMMMd('de_DE').format(dateTime);
  }

}