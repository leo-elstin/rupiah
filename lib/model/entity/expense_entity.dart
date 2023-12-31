import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class ExpenseEntity {
  final double amount;
  final int id;

  final ExpenseType type;
  final DateTime? dateTime;
  final String? description;
  final int? accountId;
  final int? categoryId;

  const ExpenseEntity({
    this.id = 0,
    this.amount = 0.0,
    this.type = ExpenseType.outgoing,
    this.dateTime,
    this.description,
    this.accountId,
    this.categoryId,
  });

  factory ExpenseEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    int seconds = map['date'] ?? 0;
    var date = DateTime.fromMillisecondsSinceEpoch(seconds);
    return ExpenseEntity(
      dateTime: map['date'] != null ? date : null,
      amount: map['amount'] ?? 0.0,
      type: ExpenseType.values[map['type']],
      description: map['description'],
      id: map['id'],
      accountId: map['accountId'],
      categoryId: map['categoryId'],
    );
  }

  String formattedDate() {
    return DateFormat('MMM, dd hh:mm a').format(dateTime!);
  }

  ExpenseEntity copyWith({
    int? id,
    double? amount,
    ExpenseType? type,
    DateTime? dateTime,
    String? description,
    int? accountId,
    int? categoryId,
  }) {
    return ExpenseEntity(
      id: id ?? this.id,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
      accountId: accountId ?? this.accountId,
      categoryId: categoryId ?? this.categoryId,
    );
  }
}

enum ExpenseType { income, outgoing, savings }
