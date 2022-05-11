import 'package:intl/intl.dart';

String convertDoubleToCurrency(number) {
  final format = NumberFormat.currency(
    locale: 'tr_TR',
    customPattern: '###,###.###',
    decimalDigits: 0,
  );

  return format.format(number);
}
