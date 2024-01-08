import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

part 'dashboard_state.dart';

class DashboardCubit extends Cubit<DashboardState> {
  DashboardCubit() : super(DashboardInitial());

  double savings = 0;
  double mutualFund = 0;

  void expense() async {
    ExpenseTable().allExpensesBeforeToday().then((value) {
      savings = value.fold(0.0, (previousValue, element) {
        if (element.type == ExpenseType.income) {
          return previousValue += element.amount;
        } else {
          return previousValue -= element.amount;
        }
      });
    });

    emit(DashboardInitial());
  }

  void update(double value) {
    mutualFund = value;
    emit(DashboardInitial());
  }

  String totalAmount() {
    double balance = savings + mutualFund;
    String locale = 'en_IN';

    if (balance < 100000) {
      locale = 'en_US';
    }
    return NumberFormat.compactCurrency(
      symbol: currencySymbol,
      locale: locale,
    ).format(balance);
  }

  double get balance => savings + mutualFund;
}
