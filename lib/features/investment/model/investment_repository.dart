import 'package:expense_kit/features/investment/model/investment_model.dart';

abstract class InvestmentRepository {
  Future<void> createInvestment(
    int id,
    String? description,
    double amount,
    DateTime? endDate,
    InvestmentType type,
  );

  Future<void> deleteInvestment(String id);

  Future<void> updateInvestment(String id, String name, double value);

  Future<List<InvestmentModel>> getInvestments();
}
