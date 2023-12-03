import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';

class CurrencyUtils {
  static String currencySymbol = '₹';
}

String currencySymbol = '₹';

final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
  symbol: '$currencySymbol ',
  locale: 'en_IN',
  decimalDigits: 2,
);
