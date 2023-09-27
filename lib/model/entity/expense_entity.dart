import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class ExpenseEntity {
  final double amount;
  final int id;

  final ExpenseType type;
  final DateTime? dateTime;
  final String? description;

  const ExpenseEntity({
    this.id = 0,
    this.amount = 0.0,
    this.type = ExpenseType.outgoing,
    this.dateTime,
    this.description,
  });

  factory ExpenseEntity.fromMap(
    Map<String, dynamic> map,
  ) {
    print(map);

    int seconds = map['date'] ?? 0;
    var date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
    return ExpenseEntity(
      dateTime: map['date'] != null ? date : null,
      amount: map['amount'] ?? 0.0,
      type: ExpenseType.values[map['type']],
      description: map['description'],
      id: map['id'],
    );
  }

  String formattedDate() {
    return DateFormat('hh:mm aa').format(dateTime!);
  }

  ExpenseEntity copyWith({
    double? amount,
    ExpenseType? type,
    DateTime? dateTime,
    String? description,
  }) {
    return ExpenseEntity(
      amount: amount ?? this.amount,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      description: description ?? this.description,
    );
  }
}

enum ExpenseType { income, outgoing, savings }
