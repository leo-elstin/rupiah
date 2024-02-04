import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/mf_central_entity.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final DashboardCubit dashboardCubit;

  SavingsCubit({required this.dashboardCubit}) : super(SavingsInitial());

  List<MutualFundData> _funds = [];

  List<MutualFundData> get funds => _funds;

  double mutualFundBalance = 0;
  double stockBalance = 0;
  double goldBalance = 0;
  double epfBalance = 469195;
  double realEstateBalance = 0;

  double get total =>
      mutualFundBalance + stockBalance + goldBalance + epfBalance + realEstateBalance;

  double get profit => _funds.fold(
        0.0,
        (previousValue, element) => previousValue + (element.currentValue ?? 0.0),
      );

  double get profitPercentage =>
      _funds.fold(
        0.0,
        (previousValue, element) => previousValue + (element.gainPercentage ?? 0.0),
      ) /
      _funds.length;

  double get invested => _funds.fold(
        0.0,
        (previousValue, element) => previousValue + (element.amount),
      );

  void getFunds() async {
    _funds.clear();
    _funds = await MutualFundQuery().allMutualFunds();

    mutualFundBalance = _funds.fold(
      0.0,
      (previousValue, element) => previousValue + element.units * (element.nav ?? 0.0),
    );

    dashboardCubit.update(mutualFundBalance);

    emit(FundLoaded());
  }

  void updateMutualFunds(PortfolioData data) {
    mutualFundBalance = data.data.fold(
      0.0,
      (previousValue, element) =>
          previousValue +
          double.parse(
            element.schemes.first.currentMktValue,
          ),
    );

    dashboardCubit.update(mutualFundBalance);
    emit(FundLoaded());
  }

  void deleteFund(MutualFundData data) async {
    await MutualFundQuery().delete(data.id);
    _funds.removeWhere((element) => element.id == data.id);
    emit(FundLoaded());
  }

  void update(double stocks, double mf) {
    mutualFundBalance = mf;
    stockBalance = stocks;
    dashboardCubit.update(total);

    emit(FundLoaded());
  }
}
