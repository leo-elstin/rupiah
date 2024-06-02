import 'package:expense_kit/features/funds/model/fund_repo.dart';
import 'package:expense_kit/features/funds/model/fund_service.dart';
import 'package:expense_kit/features/funds/model/mutual_fund_model.dart';
import 'package:expense_kit/features/funds/model/stock_model.dart';

class MutualFundRepoImpl extends MutualFundRepository {
  final MutualFundService service;

  MutualFundRepoImpl({required this.service});

  @override
  Future<List<MutualFundModel>> getMutualFunds() async {
    List<Map<String, String>>? fundData = await service.getFunds();

    return fundData!.map((json) => MutualFundModel.fromGsheets(json)).toList();
  }

  @override
  Future<List<StockModel>> getStocks() async {
    List<Map<String, String>>? fundData = await service.getStocks();

    return fundData!.map((json) => StockModel.fromGsheets(json)).toList();
  }
}
