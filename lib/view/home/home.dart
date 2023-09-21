import 'package:expense_kit/view/expense/add_expense.dart';
import 'package:expense_kit/view/expense/balance_card.dart';
import 'package:expense_kit/view/expense/expense_list.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Column(
        children: [
          SafeArea(child: BalanceCard()),
          Expanded(child: ExpenseList()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.expenseSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
