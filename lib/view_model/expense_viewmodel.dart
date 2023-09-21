import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<Expense>> {
  ExpenseNotifier() : super([]);

  void addExpense(Expense expense) {
    state = [...state, expense];
  }

  void removeExpense(Expense expense) {
    state = state.where((e) => e.dateTime != expense.dateTime).toList();
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<Expense>>((ref) {
  return ExpenseNotifier();
});
