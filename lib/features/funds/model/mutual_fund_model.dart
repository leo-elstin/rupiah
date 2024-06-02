class MutualFundModel {
  final String name;
  final String navId; // Assuming NAV date is a String
  final String investedAmount;
  final String units;
  final String price;
  final String currentAmount;
  final String profit;
  final String percentage;

  MutualFundModel({
    required this.name,
    required this.navId,
    required this.investedAmount,
    required this.units,
    required this.price,
    required this.currentAmount,
    required this.profit,
    required this.percentage,
  });

  factory MutualFundModel.fromGsheets(Map<String, dynamic> json) {
    return MutualFundModel(
      name: json['name'],
      navId: json['navId'],
      investedAmount: json['investedAmount'],
      units: json['units'],
      price: json['price'],
      currentAmount: json['currentAmount'],
      profit: json['profit'],
      percentage: json['percentage'],
    );
  }

  // toJson
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'navId': navId,
      'investedAmount': investedAmount,
      'units': units,
      'price': price,
      'currentAmount': currentAmount,
      'profit': profit,
      'percentage': percentage,
    };
  }

  Map<String, dynamic> toGsheets() {
    return {
      'name': name,
      'navId': navId,
      'investedAmount': investedAmount,
      'units': units,
      'price': price,
      'currentAmount': currentAmount,
      'profit': profit,
      'percentage': percentage,
    };
  }
}
