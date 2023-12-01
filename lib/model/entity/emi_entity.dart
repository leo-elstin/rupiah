import 'package:intl/intl.dart';

class EMIEntity {
  final String? description;
  final double amount;
  final DateTime? endDate;
  final String? id;

  const EMIEntity({
    this.description,
    this.amount = 0.0,
    this.endDate,
    this.id,
  });

  String formattedDate() {
    return endDate != null ? DateFormat('yyyy MMM').format(endDate!) : '';
  }

  EMIEntity copyWith({
    String? description,
    double? amount,
    DateTime? endDate,
    String? id,
  }) {
    return EMIEntity(
      description: description ?? this.description,
      amount: amount ?? this.amount,
      endDate: endDate ?? this.endDate,
      id: id ?? this.id,
    );
  }
}
