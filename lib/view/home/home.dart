import 'package:expense_kit/view/expense/add_expense.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: const Center(
        child: Text('Hello, World!'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.expenseSheet(),
        child: const Icon(Icons.add),
      ),
    );
  }
}
