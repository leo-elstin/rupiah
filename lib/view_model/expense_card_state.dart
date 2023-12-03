import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_card_entity.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseCardState extends StateNotifier<ExpenseCardEntity> {
  ExpenseCardState() : super(ExpenseCardEntity());

  void init() {
    ExpenseTable().expenseStream().watch().listen((event) async {
      state = ExpenseCardEntity();

      double amount = 0;
      double expense = 0;

      for (var value in event) {
        ExpenseEntity entity = ExpenseEntity.fromMap(value.toJson());
        if (entity.type == ExpenseType.income) {
          amount += entity.amount;
        } else if (entity.type == ExpenseType.outgoing) {
          expense += entity.amount;
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
