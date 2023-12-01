import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

@immutable
class ExpenseEntity {
  final double amount;
  final String id;

  final ExpenseType type;
  final DateTime? dateTime;
  final String? description;
  final String? accountId;
  final int? categoryId;

  const ExpenseEntity({
    this.id = '',
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
    var date = DateTime.fromMillisecondsSinceEpoch(seconds * 1000);
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

  // to json
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'amount': amount,
      'type': type.index,
      'date': dateTime?.millisecondsSinceEpoch,
      'description': description,
      'accountId': accountId,
      'categoryId': categoryId,
    };
  }

  String formattedDate() {
    return DateFormat('MMM, dd hh:mm a').format(dateTime!);
  }

  ExpenseEntity copyWith({
    double? amount,
    ExpenseType? type,
    DateTime? dateTime,
    String? description,
    String? accountId,
    int? categoryId,
  }) {
    return ExpenseEntity(
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
