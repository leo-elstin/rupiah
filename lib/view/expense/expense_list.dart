import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ExpenseList extends ConsumerWidget {
  const ExpenseList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      itemCount: ref.watch(expenseProvider).length,
      itemBuilder: (context, index) {
        final expense = ref.watch(expenseProvider)[index];
        return ListTile(
          title: Text(expense.type.name),
          subtitle: Text(expense.amount.toString()),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              ref.read(expenseProvider.notifier).removeExpense(expense);
            },
          ),
        );
      },
    );
  }
}
