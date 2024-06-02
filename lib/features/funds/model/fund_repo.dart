import 'package:expense_kit/features/funds/model/mutual_fund_model.dart';
import 'package:expense_kit/features/funds/model/stock_model.dart';

abstract class MutualFundRepository {
  Future<List<MutualFundModel>> getMutualFunds();
  Future<List<StockModel>> getStocks();
}
