import 'package:flutter/foundation.dart';

@immutable
class Expense {
  final double amount;

  final ExpenseType type;
  final DateTime dateTime;

  const Expense({
    required this.amount,
    required this.type,
    required this.dateTime,
  });
}

enum ExpenseType { income, outgoing, saving }
