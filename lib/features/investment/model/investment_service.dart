import 'package:drift/drift.dart';
import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:expense_kit/model/database/database.dart';

class InvestmentService {
  final database = Database();

  Future<List<InvestmentModel>> getInvestments() async {
    List<InvestmentData> data = await database.select(database.investment).get();

    return data
        .map((e) => InvestmentModel(
              id: e.id,
              description: e.description,
              investedValue: e.investedValue,
              currentValue: e.currentValue,
              investedDate: e.investedDate,
              type: e.type,
            ))
        .toList();
  }

  Future<void> addInvestment(InvestmentModel investment) async {
    database.into(database.investment).insert(
          InvestmentCompanion.insert(
            investedValue: investment.investedValue ?? 0.0,
            currentValue: investment.currentValue ?? 0.0,
            type: investment.type ?? InvestmentType.others,
            description: Value(investment.description),
            investedDate: Value(investment.investedDate),
          ),
        );
  }
//
// Future<Investment> updateInvestment(Investment investment) async {
//   // Update investment on the server
// }
//
// Future<void> deleteInvestment(int id) async {
//   // Delete investment from the server
// }
}
