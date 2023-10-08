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
