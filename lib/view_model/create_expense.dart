import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNotifier extends StateNotifier<ExpenseEntity> {
  CreateNotifier() : super(const ExpenseEntity());

  void addExpense(ExpenseEntity expense) {
    state = expense;
  }

  void updateExpense(ExpenseEntity expense) {
    state = expense;
  }

  void amount(double amount) {
    if (amount > 0) {
      state = state.copyWith(amount: amount);
    } else {
      state = state.copyWith(amount: null);
    }
  }
}

final createExpense =
    StateNotifierProvider<CreateNotifier, ExpenseEntity>((ref) {
  return CreateNotifier();
});
