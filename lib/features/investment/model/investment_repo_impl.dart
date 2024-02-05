import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:expense_kit/features/investment/model/investment_repository.dart';
import 'package:expense_kit/features/investment/model/investment_service.dart';

class InvestmentRepoImpl extends InvestmentRepository {
  final InvestmentService service;

  InvestmentRepoImpl({required this.service});

  @override
  Future<void> createInvestment(
    InvestmentModel investmentModel,
  ) async {
    await service.addInvestment(investmentModel);
  }

  @override
  Future<void> deleteInvestment(String id) {
    throw UnimplementedError();
  }

  @override
  Future<List<InvestmentModel>> getInvestments() async {
    return await service.getInvestments();
  }

  @override
  Future<void> updateInvestment(String id, String name, double value) {
    throw UnimplementedError();
  }
}
