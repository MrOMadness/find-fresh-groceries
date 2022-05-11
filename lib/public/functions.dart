import 'package:intl/intl.dart';

// function to convert number(double) to currency
String convertDoubleToCurrency(number) {
  final format = NumberFormat.currency(
    locale: 'tr_TR',
    customPattern: '###,###.###',
    decimalDigits: 0,
  );

  return format.format(number);
}
