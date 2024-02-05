enum InvestmentType {
  mutualFund,
  stocks,
  gold,
  realEstate,
  epf,
  ppf,
  others,
}

class InvestmentModel {
  int? id;
  final String? description;
  double? investedValue;
  double? currentValue;
  DateTime? investedDate;
  InvestmentType? type;

  InvestmentModel({
    this.id,
    this.description,
    this.investedValue,
    this.currentValue,
    this.investedDate,
    this.type,
  });

  bool get isValid =>
      description != null &&
      investedValue != null &&
      currentValue != null &&
      investedDate != null &&
      type != null;

  // toString method
  @override
  String toString() {
    return 'InvestmentModel{id: $id, '
        'description: $description, '
        'investedValue: $investedValue, '
        'investedDate: $investedDate, '
        'type: $type}';
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'description': description,
      'investedValue': investedValue,
      'currentValue': currentValue,
      'investedDate': investedDate?.toIso8601String(),
      'type': type?.index,
    };
  }

  // copyWith
  InvestmentModel copyWith({
    int? id,
    String? description,
    double? investedValue,
    double? currentValue,
    DateTime? investedDate,
    InvestmentType? type,
  }) {
    return InvestmentModel(
      id: id ?? this.id,
      description: description ?? this.description,
      investedValue: investedValue ?? this.investedValue,
      currentValue: currentValue ?? this.currentValue,
      investedDate: investedDate ?? this.investedDate,
      type: type ?? this.type,
    );
  }
}
