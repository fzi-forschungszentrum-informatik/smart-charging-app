import 'package:intl/intl.dart';

class NumberFormatters {
  static final NumberFormat regEuroFormatter = NumberFormat.currency(
    locale: 'eu',
    symbol: '€',
  );
  static final NumberFormat euroFormatterWithPlusSign = NumberFormat.currency(
    locale: 'eu',
    symbol: '€',
    customPattern: '+##### €',
  );
  static final NumberFormat kWFormatter = NumberFormat('####0.0 kW', 'DE');
  static final NumberFormat kwhFormatter = NumberFormat('###0.0# kWh', 'DE');
}
