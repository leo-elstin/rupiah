import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_card_entity.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCardState extends StateNotifier<ExpenseCardEntity> {
  ExpenseCardState() : super(ExpenseCardEntity());

  void init() {
    ExpenseTable().stream().listen((event) {
      state = ExpenseCardEntity();
      double amount = 0;
      double expense = 0;
      for (var value in event) {
        if (value.type == ExpenseType.income) {
          amount += value.amount;
        } else if (value.type == ExpenseType.outgoing) {
          expense += value.amount;
        }
      }

      state = ExpenseCardEntity(
        income: amount,
        expense: expense,
        totalBalance: amount - expense,
      );
    });
  }
}

final expenseCardState =
    StateNotifierProvider<ExpenseCardState, ExpenseCardEntity>((ref) {
  return ExpenseCardState()..init();
});
