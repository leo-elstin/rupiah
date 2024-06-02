import 'package:expense_kit/features/funds/model/fund_repo_impl.dart';
import 'package:expense_kit/features/funds/model/fund_service.dart';
import 'package:expense_kit/features/funds/model/mutual_fund_model.dart';
import 'package:expense_kit/features/funds/model/stock_model.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'mutual_fund_state.dart';

class MutualFundCubit extends Cubit<MutualFundState> {
  final SavingsCubit savingsCubit;

  MutualFundCubit({required this.savingsCubit}) : super(MutualFundInitial());

  List<MutualFundModel> _list = [];

  // get
  List<MutualFundModel> get funds => _list;

  void get() async {
    List<MutualFundModel> items =
        await MutualFundRepoImpl(service: MutualFundService()).getMutualFunds();
    List<StockModel> stocksList =
        await MutualFundRepoImpl(service: MutualFundService()).getStocks();

    _list = items;

    double currentMF = _list.fold(
      0.0,
      (previousValue, element) => double.parse(element.currentAmount) + previousValue,
    );

    // stocks
    double stocks = stocksList.fold(
      0.0,
      (previousValue, element) => double.parse(element.currentAmount) + previousValue,
    );

    // invested
    double investedMF = _list.fold(
      0.0,
      (previousValue, element) => double.parse(element.investedAmount) + previousValue,
    );

    // invested Stock
    double investedStocks = stocksList.fold(
      0.0,
      (previousValue, element) => double.parse(element.investedAmount) + previousValue,
    );

    double profit = (currentMF - investedMF) + (stocks - investedStocks);

    savingsCubit.update(
      stocks,
      currentMF,
      invested: investedMF + investedStocks,
      profit: profit,
    );
    emit(MutualFundsLoaded());
  }
}
