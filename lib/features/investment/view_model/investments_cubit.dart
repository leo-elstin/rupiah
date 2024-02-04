import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'investments_state.dart';

class InvestmentsCubit extends Cubit<InvestmentsState> {
  InvestmentsCubit() : super(InvestmentsInitial());

  InvestmentModel investmentModel = InvestmentModel();

  set investmentType(InvestmentType value) {
    investmentModel.copyWith(type: value);
    emit(InvestmentUpdated());
  }

  set investmentAmount(double value) {
    investmentModel.copyWith(amount: value);
    emit(InvestmentUpdated());
  }

  set investmentEndDate(DateTime value) {
    investmentModel.copyWith(endDate: value);
    emit(InvestmentUpdated());
  }

  set investmentDescription(String value) {
    investmentModel.copyWith(description: value);
    emit(InvestmentUpdated());
  }

  List<InvestmentType> get investmentTypes => InvestmentType.values;
}
