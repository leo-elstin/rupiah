import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<ExpenseEntity>> {
  ExpenseNotifier() : super([]);

  Future addExpense(ExpenseEntity expense) async {
    await ExpenseTable().insert(expense);
    await getAll();
  }

  void removeExpense(ExpenseEntity expense) {
    ExpenseTable().remove(expense);
    getAll();
  }

  Future getAll() async {
    state = await ExpenseTable().allExpensesBeforeToday();
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<ExpenseEntity>>((ref) {
  return ExpenseNotifier();
});
