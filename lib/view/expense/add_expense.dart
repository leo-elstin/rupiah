import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:expense_kit/view_model/create_expense.dart';
import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
      symbol: '${CurrencyUtils.currencySymbol} ',
      locale: 'en_IN',
    );
    ExpenseEntity expense = ref.watch(createExpense);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: ListView(
            children: [
              Text(
                'Choose Type',
                style: context.boldBody(),
              ),
              DropdownButtonFormField(
                decoration: textDecoration.copyWith(
                  labelText: 'Expense Type',
                  labelStyle: context.titleLarge(),
                ),
                style: context.body(),
                isExpanded: true,
                value: expense.type,
                onChanged: (value) {
                  ref.read(createExpense.notifier).updateExpense(
                        expense.copyWith(
                          type: value as ExpenseType,
                        ),
                      );
                },
                items: ExpenseType.values
                    .map(
                      (e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e.name.toUpperCase(),
                          style: context.body(),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),
              Text('Amount', style: context.boldBody()),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'Enter the amount',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  ref.read(createExpense.notifier).amount(
                        formatter.getUnformattedValue().toDouble(),
                      );
                },
              ),
              const SizedBox(height: 16),
              Text('Description', style: context.boldBody()),
              TextField(
                  style: context.body(),
                  decoration: textDecoration.copyWith(
                    labelText: 'Enter the Description',
                    hintText: 'Optional',
                    labelStyle: context.titleLarge(),
                  ),
                  onChanged: (value) {
                    ref.read(createExpense.notifier).updateExpense(
                          expense.copyWith(
                            description: value,
                          ),
                        );
                  }),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: SafeArea(
          child: Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    ref.invalidate(createExpense);
                    context.pop();
                  },
                  child: const Text('Cancel'),
                ),
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    elevation: 4,
                  ),
                  onPressed: expense.amount > 0
                      ? () {
                          ref
                            ..read(expenseProvider.notifier).addExpense(expense)
                            ..invalidate(createExpense);

                          context.pop();
                        }
                      : null,
                  child: const Text('Add Expense'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
