import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final DashboardCubit dashboardCubit;

  SavingsCubit({required this.dashboardCubit}) : super(SavingsInitial());

  double mutualFundBalance = 0;
  double stockBalance = 0;
  double goldBalance = 0;
  double epfBalance = 516103;
  double realEstateBalance = 0;

  double profit = 0;
  double invested = 0;
  double profitPercentage = 0;

  double get total =>
      mutualFundBalance + stockBalance + goldBalance + epfBalance + realEstateBalance;

  void update(double stocks, double mf, {double invested = 0, double profit = 0}) {
    mutualFundBalance = mf;
    stockBalance = stocks;
    this.profit += profit;
    this.invested += invested + epfBalance;
    dashboardCubit.update(total);
    profitPercentage = (this.profit / this.invested) * 100;
    emit(FundLoaded());
  }
}
