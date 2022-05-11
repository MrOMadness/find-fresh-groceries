import 'package:intl/intl.dart';

String convertDoubleToCurrency(number) {
  final format = NumberFormat.currency(
      // locale: 'eu',
      customPattern: '#,### \u00a4',
      symbol: 'IDR',
      decimalDigits: 2);

  return format.format(number);
}
