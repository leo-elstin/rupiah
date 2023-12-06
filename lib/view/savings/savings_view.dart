import 'package:expense_kit/view/savings/savings_details.dart';
import 'package:flutter/material.dart';

class SavingView extends StatefulWidget {
  const SavingView({super.key});

  @override
  State<SavingView> createState() => _SavingViewState();
}

class _SavingViewState extends State<SavingView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: const Column(
        children: [
          SavingsDetails(),
        ],
      ),
    );
  }
}
