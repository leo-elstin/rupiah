import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:expense_kit/features/investment/model/investment_repo_impl.dart';
import 'package:expense_kit/features/investment/model/investment_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'investments_state.dart';

class InvestmentsCubit extends Cubit<InvestmentsState> {
  InvestmentsCubit() : super(InvestmentsInitial());

  final InvestmentRepoImpl repo = InvestmentRepoImpl(service: InvestmentService());

  InvestmentModel investmentModel = InvestmentModel();

  set investmentType(InvestmentType value) {
    investmentModel.copyWith(type: value);
    emit(InvestmentUpdated());
  }

  set investedValue(double value) {
    investmentModel.copyWith(investedValue: value);
    emit(InvestmentUpdated());
  }

  set currentValue(double value) {
    investmentModel.copyWith(currentValue: value);
    emit(InvestmentUpdated());
  }

  set investedDate(DateTime value) {
    investmentModel.copyWith(investedDate: value);
    emit(InvestmentUpdated());
  }

  set description(String value) {
    investmentModel.copyWith(description: value);
    emit(InvestmentUpdated());
  }

  List<InvestmentType> get investmentTypes => InvestmentType.values;

  void saveInvestment() async {
    repo.createInvestment(investmentModel);
  }
}
