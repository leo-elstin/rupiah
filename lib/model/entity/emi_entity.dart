import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';

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
    num val = Jiffy.parseFromDateTime(
      DateTime(
        endDate!.year,
        endDate!.month,
        30,
      ),
    ).diff(Jiffy.now(), unit: Unit.month);

    if (kDebugMode) {
      print(val);
      print(endDate);
    }

    return amount * val;
  }

  num pendingMonths() {
    num val = Jiffy.parseFromDateTime(
      DateTime(
        endDate!.year,
        endDate!.month,
        30,
      ),
    ).diff(Jiffy.now(), unit: Unit.month);

    return val;
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
