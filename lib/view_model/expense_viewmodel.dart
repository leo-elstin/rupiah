import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseNotifier extends StateNotifier<List<ExpenseEntity>> {
  ExpenseNotifier() : super([]);

  Future add(ExpenseEntity expense) async {
    await ExpenseTable().insert(expense);
    await getAll();
  }

  Future update(ExpenseEntity expense) async {
    await ExpenseTable().insert(expense);
    await getAll();
  }

  void removeExpense(ExpenseEntity expense) {
    ExpenseTable().remove(expense);
    getAll();
  }

  Future getAll() async {
    state = await ExpenseTable().allExpensesBeforeToday();
    var emiList = await EMITable().get();
    var newList = emiList
        .where(
          (element) => DateTime.now().isBefore(element.endDate!),
        )
        .toList();

    var temps = newList
        .map((e) => ExpenseEntity(
              description: e.description,
              amount: e.amount,
              type: ExpenseType.outgoing,
              dateTime: DateTime(DateTime.now().year, DateTime.now().month),
            ))
        .toList();
    state.addAll(temps);
  }
}

final expenseProvider =
    StateNotifierProvider<ExpenseNotifier, List<ExpenseEntity>>((ref) {
  return ExpenseNotifier();
});
