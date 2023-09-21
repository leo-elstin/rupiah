import 'package:flutter/foundation.dart';

@immutable
class Expense {
  final double amount;

  final ExpenseType type;
  final DateTime? dateTime;
  final String? description;

  const Expense({
    this.amount = 0.0,
    this.type = ExpenseType.outgoing,
    this.dateTime,
    this.description,
  });

  Expense copyWith({
    double? amount,
    ExpenseType? type,
    DateTime? dateTime,
    String? description,
  }) {
    return Expense(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
    );
  }
}

enum ExpenseType { income, outgoing, savings }
