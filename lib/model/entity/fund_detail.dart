import 'package:expense_kit/model/entity/mutual_fund.dart';

class FundDetails {
  final int id;
  final String fundId;
  final double units;
  final double invested;
  final MutualFundEntity fund;
  final String logoPath;

  FundDetails({
    required this.id,
    required this.fundId,
    required this.units,
    required this.invested,
    required this.fund,
    required this.logoPath,
  });

  double get profitPercent =>
      (((fund.currentNav * units) - invested) / invested) * 100;

  double get profit => ((fund.currentNav * units) - invested);
}
