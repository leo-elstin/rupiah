import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/fund_detail.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final DashboardCubit dashboardCubit;

  SavingsCubit({required this.dashboardCubit}) : super(SavingsInitial());

  final List<FundDetails> _funds = [];

  List<FundDetails> get funds => _funds;

  double mutualFundBalance = 0;
  double stockBalance = 0;
  double goldBalance = 2700000;
  double epfBalance = 420000;
  double realEstateBalance = 10700000;

  double get total =>
      mutualFundBalance +
      stockBalance +
      goldBalance +
      epfBalance +
      realEstateBalance;

  double get profit => _funds.fold(
        0.0,
        (previousValue, element) => previousValue + element.profit,
      );

  double get profitPercentage =>
      _funds.fold(
        0.0,
        (previousValue, element) => previousValue + element.profitPercent,
      ) /
      _funds.length;

  double get invested => _funds.fold(
        0.0,
        (previousValue, element) => previousValue + element.invested,
      );

  void getFunds() async {
    _funds.clear();
    List<MutualFundData> list = await MutualFundQuery().allMutualFunds();

    for (var value in list) {
      var fund = await MutualFundService().getDetails(value.fundId.toString());
      if (fund != null) {
        _funds.add(
          FundDetails(
            id: value.id,
            fund: fund,
            fundId: value.fundId.toString(),
            units: value.units,
            invested: value.amount,
            logoPath: value.fundId.toString() == '120828'
                ? 'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=none,width=100/https://indcdn.indmoney.com/public/images/amc_quant.png'
                : value.fundId.toString() == '120620'
                    ? 'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=none,width=100/https://indcdn.indmoney.com/public/images/amc_icici.png'
                    : value.fundId.toString() == '118778'
                        ? 'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=none,width=100/https://indcdn.indmoney.com/public/images/amc_nippon.png'
                        : '',
          ),
        );
      }
    }

    mutualFundBalance = _funds.fold(
      0.0,
      (previousValue, element) =>
          previousValue + element.units * element.fund.currentNav,
    );

    dashboardCubit.update(
      mutualFundBalance + stockBalance + goldBalance + epfBalance,
    );

    emit(FundLoaded());
  }

  void deleteFund(FundDetails data) async {
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
