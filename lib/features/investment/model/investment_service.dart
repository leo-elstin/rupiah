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
              amount: e.amount,
              endDate: e.endDate,
              type: e.type,
            ))
        .toList();
  }

  // Future<Investment> getInvestment(int id) async {
  //   // Fetch investment from the server
  // }
  //
  // Future<Investment> addInvestment(Investment investment) async {
  //   // Add investment to the server
  // }
  //
  // Future<Investment> updateInvestment(Investment investment) async {
  //   // Update investment on the server
  // }
  //
  // Future<void> deleteInvestment(int id) async {
  //   // Delete investment from the server
  // }
}
