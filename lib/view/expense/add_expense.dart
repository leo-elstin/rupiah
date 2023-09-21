import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AddExpense extends StatelessWidget {
  const AddExpense({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Choose Type',
                style: context.boldBody(),
              ),
              DropdownButton(
                underline: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.blueGrey,
                ),
                style: context.body(),
                isExpanded: true,
                // value: selectedDropDownValue,
                onChanged: (value) {},
                items: [
                  DropdownMenuItem(
                    value: 'income',
                    child: Text(
                      'Income',
                      style: context.body(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'expense',
                    child: Text(
                      'Expense',
                      style: context.body(),
                    ),
                  ),
                  DropdownMenuItem(
                    value: 'savings',
                    child: Text(
                      'Savings',
                      style: context.body(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text('Amount', style: context.boldBody()),
              TextField(
                style: context.body(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                ],
                decoration: textDecoration,
              ),
              const SizedBox(height: 16),
              Text('Description', style: context.boldBody()),
              TextField(
                style: context.body(),
                maxLines: 2,
                decoration: textDecoration,
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 2,
                  ),
                  onPressed: () {},
                  child: const Text('Add Expense'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

extension Sheets on BuildContext {
  void expenseSheet() {
    showModalBottomSheet(
      context: this,
      builder: (context) => const AddExpense(),
    );
  }
}
