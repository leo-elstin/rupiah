import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:meta/meta.dart';

part 'mutual_fund_state.dart';

class MutualFundCubit extends Cubit<MutualFundState> {
  MutualFundCubit() : super(MutualFundInitial());

  final _service = MutualFundService();

  List<Scheme> _masterFunds = [];
  List<Scheme> _funds = [];

  List<Scheme> get funds => _funds;

  void searchFund(String query) {
    emit(MutualFundLoading());
    _funds = _masterFunds
        .where(
          (element) => element.schemeName
              .replaceAll('-', ' ')
              .toLowerCase()
              .contains(query.toLowerCase()),
        )
        .toList();
    emit(MutualFundLoaded());
  }

  void clear() {
    _funds.clear();
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

  void calculateSip() async {
    // var fund1 = await MutualFundService().getDetails('120828');
    double _monthlyInvestment = 2000;
    double _expectedReturnRate = 9.85;
    double _timePeriod = 1;
    double _investedAmount = 8000;
    double _totalInvestment;
    double _result;
    double i;

    i = (_expectedReturnRate) / (12 * 100);

    _result = (_monthlyInvestment *
            (((pow((1 + i), (_timePeriod * 12))) - 1) / i) *
            (1 + i)) -
        _investedAmount;

    _totalInvestment = _investedAmount + _result;

    print(_totalInvestment);
  }
}
