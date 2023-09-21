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
    return Theme.of(this).textTheme.bodyLarge?.copyWith(
          color: Colors.white,
        );
  }

  TextStyle? medium() {
    return Theme.of(this).textTheme.bodyMedium?.copyWith(
          color: Colors.white,
        );
  }

  TextStyle? small() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          color: Colors.white,
        );
  }

  TextStyle? smaller() {
    return Theme.of(this).textTheme.bodySmall?.copyWith(
          color: Colors.white,
          fontSize: 12,
        );
  }

  TextStyle? boldBody() {
    return Theme.of(this).textTheme.bodyLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        );
  }
}
