import 'package:expense_kit/utils/currency_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

extension ValidateEmail on String {
  bool isValidEmail() => RegExp(r'^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$').hasMatch(this);

  bool isValidPassword() =>
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$').hasMatch(this);

  String capitalize() {
    return isNotEmpty ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  }
}

extension NavigationExtension on BuildContext {
  TextStyle? body() {
    return Theme.of(this).textTheme.bodyLarge?.copyWith();
  }

  TextStyle? medium() {
    return Theme.of(this).textTheme.bodyMedium?.copyWith();
  }

  TextStyle? mediumBold() {
    return Theme.of(this).textTheme.bodyMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? small() {
    return Theme.of(this).textTheme.bodySmall?.copyWith();
  }

  TextStyle? smallBold() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? smaller() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          fontSize: 12,
        );
  }

  TextStyle? hintText() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          fontSize: 14,
          color: Colors.grey,
        );
  }

  TextStyle? smallerBold() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? boldBody() {
    return Theme.of(this).textTheme.bodyLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? titleLarge() {
    return Theme.of(this).textTheme.titleLarge;
  }

  TextStyle? titleLargeBold() {
    return Theme.of(this).textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? titleMedium() {
    return Theme.of(this).textTheme.titleMedium?.copyWith();
  }

  TextStyle? titleSmall() {
    return Theme.of(this).textTheme.titleSmall?.copyWith();
  }

  void hideKeyboard() {
    FocusScope.of(this).unfocus();
  }
}

extension UIExtensionOnContext on BuildContext {
  double get height => MediaQuery.of(this).size.height;

  double get width => MediaQuery.of(this).size.width;

  bool get isTab => MediaQuery.of(this).size.width > 600;

  // this height is based on the device height and given value and this will auto adjust based on the device size
  double dynamicHeight(double value) => height * value;
}

extension TextWidget on String {
  Text toBody() => Text(this);
}

extension ListnerExtension on Widget {
  BlocListener listener(
    BuildContext context,
    BlocWidgetListener listener,
  ) {
    return BlocListener(
      bloc: context.read(),
      listener: listener,
      child: this,
    );
  }

  BlocBuilder update(
    Cubit cubit,
  ) {
    return BlocBuilder(
      bloc: cubit,
      builder: (context, state) => this,
    );
  }
}

extension SizeExtension on double {
  SizedBox width() => SizedBox(
        width: this,
      );

  SizedBox height() => SizedBox(
        height: this,
      );

  String toCurrency() {
    String locale = 'en_IN';
    if (this > 0 && this < 100000) {
      locale = 'en_US';
    }
    return NumberFormat.compactCurrency(
      symbol: '$currencySymbol ',
      locale: locale,
      decimalDigits: 2,
    ).format(
      this,
    );
  }
}
