import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:expense_kit/view_model/create_expense.dart';
import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddExpense extends ConsumerStatefulWidget {
  const AddExpense({super.key});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  TextEditingController dateController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(createExpense, (previous, next) {
      if (next.dateTime != null) {
        dateController.text = DateFormat.yMMM().format(next.dateTime!);
      }
    });

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
              const SizedBox(height: 32),
              TextField(
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                style: context.titleMedium(),
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  formatter,
                ],
                decoration: textDecoration.copyWith(
                  labelText: 'Amount',
                  hintText: '$currencySymbol 0.00',
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  ref.read(createExpense.notifier).amount(
                        formatter.getUnformattedValue().toDouble(),
                      );
                },
              ),
              const SizedBox(height: 32),
              TextField(
                controller: dateController,
                onTap: () => _showDialog(
                  CupertinoDatePicker(
                    initialDateTime: DateTime.now(),
                    mode: CupertinoDatePickerMode.date,
                    use24hFormat: true,
                    // This shows day of week alongside day of month
                    showDayOfWeek: true,
                    // This is called when the user changes the date.
                    onDateTimeChanged: (DateTime newDate) {
                      ref.read(createExpense.notifier).updateExpense(
                            expense.copyWith(
                              dateTime: newDate.add(const Duration(hours: 12)),
                            ),
                          );
                    },
                  ),
                ),
                style: context.titleMedium(),
                readOnly: true,
                decoration: textDecoration.copyWith(
                  labelText: 'Year & month',
                  hintText: DateFormat.yMMM().format(DateTime.now()),
                  labelStyle: context.titleLarge(),
                ),
                onChanged: (value) {
                  ref.read(createExpense.notifier).amount(
                        formatter.getUnformattedValue().toDouble(),
                      );
                },
              ),
              const SizedBox(height: 32),
              TextField(
                  style: context.body(),
                  decoration: textDecoration.copyWith(
                    labelText: 'Description',
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
              const SizedBox(height: 16),
              Text(
                'Account',
                style: context.body(),
              ),
              SizedBox(
                height: 75,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  shrinkWrap: true,
                  children: [
                    SizedBox(
                      height: 100,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          side: BorderSide(
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(12),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('ICICI Savings Account'),
                              Text(
                                'Leo Elstin',
                                style: context.boldBody(),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 150,
                      child: Card(),
                    ),
                  ],
                ),
              )
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

  void _showDialog(Widget child) {
    showCupertinoModalPopup<void>(
      context: context,
      builder: (BuildContext context) => Container(
        height: 216,
        padding: const EdgeInsets.only(top: 6.0),
        // The Bottom margin is provided to align the popup above the system
        // navigation bar.
        margin: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        // Provide a background color for the popup.
        color: CupertinoColors.systemBackground.resolveFrom(context),
        // Use a SafeArea widget to avoid system overlaps.
        child: SafeArea(
          top: false,
          child: child,
        ),
      ),
    );
  }
}
