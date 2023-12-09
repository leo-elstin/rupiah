import 'package:expense_kit/model/entity/fund_detail.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'savings_state.dart';

class SavingsCubit extends Cubit<SavingsState> {
  final DashboardCubit dashboardCubit;

  SavingsCubit({required this.dashboardCubit}) : super(SavingsInitial());

  final List<FundDetails> _funds = [];

  List<FundDetails> get funds => _funds;

  double mutualFundBalance = 0;

  String get mutualFundString {
    String locale = 'en_IN';
    if (mutualFundBalance < 100000) {
      locale = 'en_US';
    }
    return NumberFormat.compactCurrency(
      symbol: '$currencySymbol ',
      locale: locale,
      decimalDigits: 2,
    ).format(
      mutualFundBalance,
    );
  }

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
    // quand
    var fund1 = await MutualFundService().getDetails('120828');
    if (fund1 != null) {
      _funds.add(
        FundDetails(
          fund: fund1,
          fundId: '120828',
          units: 40.435,
          invested: 8000,
          logoPath:
              'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=copyright,width=100/https://indcdn.indmoney.com/public/images/amc_quant.png',
        ),
      );
    }

    // icici
    var icici = await MutualFundService().getDetails('120620');
    if (icici != null) {
      _funds.add(
        FundDetails(
          fund: icici,
          fundId: '120684',
          units: 62.801,
          invested: 12800,
          logoPath:
              'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=copyright,width=100/https://indcdn.indmoney.com/public/images/amc_icici.png',
        ),
      );
    }

    // Nippon
    var nippon = await MutualFundService().getDetails('118778');
    if (nippon != null) {
      _funds.add(
        FundDetails(
          fund: nippon,
          fundId: '118778',
          units: 58.186,
          invested: 8000,
          logoPath:
              'https://indcdn.indmoney.com/cdn-cgi/image/quality=90,format=auto,metadata=copyright,width=100/https://indcdn.indmoney.com/public/images/amc_nippon.png',
        ),
      );
    }

    mutualFundBalance = _funds.fold(
      0.0,
      (previousValue, element) =>
          previousValue + element.units * element.fund.currentNav,
    );

    dashboardCubit.update(mutualFundBalance);

    emit(FundLoaded());
  }
}
