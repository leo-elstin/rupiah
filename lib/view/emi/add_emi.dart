import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:expense_kit/view_model/create_expense.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class AddEMI extends ConsumerStatefulWidget {
  const AddEMI({super.key});

  @override
  ConsumerState<AddEMI> createState() => _AddEMIState();
}

class _AddEMIState extends ConsumerState<AddEMI> {
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Expense'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: SafeArea(
          child: ListView(
            children: [
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
              Text('Month & Year', style: context.boldBody()),
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
                    onDateTimeChanged: (DateTime newDate) {},
                  ),
                ),
                style: context.titleMedium(),
                readOnly: true,
                decoration: textDecoration.copyWith(
                  labelText: 'Pick year & month',
                  hintText: DateFormat.yMMM().format(DateTime.now()),
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
                  onChanged: (value) {}),
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
                  onPressed: () {},
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
