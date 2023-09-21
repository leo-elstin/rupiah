import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateNotifier extends StateNotifier<Expense> {
  CreateNotifier() : super(const Expense());

  void addExpense(Expense expense) {
    state = expense;
  }

  void updateExpense(Expense expense) {
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

final createExpense = StateNotifierProvider<CreateNotifier, Expense>((ref) {
  return CreateNotifier();
});
