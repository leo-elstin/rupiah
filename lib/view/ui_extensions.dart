import 'package:flutter/material.dart';

extension NavigationExtension on BuildContext {
  Future push({required Widget page}) {
    return Navigator.push(
      this,
      MaterialPageRoute(builder: (context) => page),
    );
  }

  void pop() {
    return Navigator.pop(this);
  }

  TextStyle? body() {
    return Theme.of(this).textTheme.bodyLarge?.copyWith();
  }

  TextStyle? medium() {
    return Theme.of(this).textTheme.bodyMedium?.copyWith();
  }

  TextStyle? small() {
    return Theme.of(this).textTheme.bodySmall?.copyWith();
  }

  TextStyle? smaller() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontSize: 12,
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

  TextStyle? titleMedium() {
    return Theme.of(this).textTheme.titleMedium?.copyWith(
          fontWeight: FontWeight.bold,
        );
  }

  TextStyle? titleSmall() {
    return Theme.of(this).textTheme.titleSmall?.copyWith();
  }
}
