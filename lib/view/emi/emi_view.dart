import 'package:expense_kit/view/emi/add_emi.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:flutter/material.dart';

class EMIView extends StatelessWidget {
  const EMIView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(page: const AddEMI()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
