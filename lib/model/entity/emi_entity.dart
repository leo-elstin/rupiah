import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class EMIEntity {
  final String? description;
  final double amount;
  final DateTime? endDate;
  final int? id;

  const EMIEntity({
    this.description,
    this.amount = 0.0,
    this.endDate,
    this.id,
  });

  String formattedDate() {
    return endDate != null ? DateFormat('yyyy MMM').format(endDate!) : '';
  }

  double pending() {
    final now = DateTime.now();
    Duration? difference = endDate?.difference(now);

    int years = difference!.inDays ~/ 365;
    int months = (difference.inDays - years * 365) ~/ 30;

    if (kDebugMode) {
      print(months);
    }

    return amount * months;
  }

  EMIEntity copyWith({
    String? description,
    double? amount,
    DateTime? endDate,
    int? id,
  }) {
    return EMIEntity(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      endDate: endDate ?? this.endDate,
      id: id ?? this.id,
    );
  }
}
