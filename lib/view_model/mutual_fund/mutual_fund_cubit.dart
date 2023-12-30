import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mutual_fund_state.dart';

class MutualFundCubit extends Cubit<MutualFundState> {
  MutualFundCubit() : super(MutualFundInitial());

  final _service = MutualFundService();

  List<Scheme> _masterFunds = [];
  List<Scheme> _funds = [];

  List<Scheme> get funds => _funds;

  void searchFund(String query) async {
    if (query.length < 4) {
      return;
    }
    emit(MutualFundLoading());

    _funds = await _service.searchFund(query: query);

    emit(MutualFundLoaded());
  }

  void clear() {
    _funds.clear();
    emit(MutualFundInitial());
  }

  void loadFunds() async {
    _funds.clear();
    if (_masterFunds.isNotEmpty) {
      _funds.addAll(_masterFunds);
      emit(MutualFundLoaded());
      return;
    }
    emit(MutualFundLoading());
    _masterFunds = await _service.getFunds();
    _funds.addAll(_masterFunds);
    emit(MutualFundLoaded());
  }

// void calculateSip() async {
//   // var fund1 = await MutualFundService().getDetails('120828');
//   double monthlyInvestment = 2000;
//   double expectedReturnRate = 9.85;
//   double timePeriod = 1;
//   double investedAmount = 8000;
//   double totalInvestment;
//   double result;
//   double i;
//
//   i = (expectedReturnRate) / (12 * 100);
//
//   result = (monthlyInvestment *
//           (((pow((1 + i), (timePeriod * 12))) - 1) / i) *
//           (1 + i)) -
//       investedAmount;
//
//   totalInvestment = investedAmount + result;
//
//   print(totalInvestment);
// }
}
