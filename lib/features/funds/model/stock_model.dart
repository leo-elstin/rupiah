class StockModel {
  final String name;
  final String price;
  final String units;
  final String currentAmount;
  final String investedAmount;

  StockModel({
    required this.name,
    required this.price,
    required this.units,
    required this.currentAmount,
    required this.investedAmount,
  });

  factory StockModel.fromGsheets(Map<String, dynamic> json) {
    return StockModel(
      name: json['name'],
      price: json['price'],
      units: json['units'],
      currentAmount: json['currentAmount'],
      investedAmount: json['investedAmount'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'units': units,
      'price': price,
      'currentAmount': currentAmount,
      'investedAmount': investedAmount,
    };
  }

  Map<String, dynamic> toGsheets() {
    return {
      'name': name,
      'units': units,
      'price': price,
      'currentAmount': currentAmount,
      'investedAmount': investedAmount,
    };
  }
}
