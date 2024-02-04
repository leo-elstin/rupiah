enum InvestmentType {
  mutualFund,
  stocks,
  gold,
  realEstate,
  epf,
  ppf,
}

class InvestmentModel {
  int? id;
  final String? description;
  double? amount;
  DateTime? endDate;
  InvestmentType? type;

  InvestmentModel({
    this.id,
    this.description,
    this.amount,
    this.endDate,
    this.type,
  });

  bool get isValid => description != null && amount != null && endDate != null && type != null;

  // toString method
  @override
  String toString() {
    return 'InvestmentModel{id: $id, '
        'description: $description, '
        'amount: $amount, '
        'endDate: $endDate, '
        'type: $type}';
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'amount': amount,
      'endDate': endDate,
      'type': type,
    };
  }

  // copyWith
  InvestmentModel copyWith({
    int? id,
    String? description,
    double? amount,
    DateTime? endDate,
    InvestmentType? type,
  }) {
    return InvestmentModel(
      id: id ?? this.id,
      description: description ?? this.description,
      amount: amount ?? this.amount,
      endDate: endDate ?? this.endDate,
      type: type ?? this.type,
    );
  }
}
