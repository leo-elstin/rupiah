import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/view/ui_extensions.dart';
import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class ExpenseList extends ConsumerStatefulWidget {
  const ExpenseList({super.key});

  @override
  ConsumerState<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends ConsumerState<ExpenseList> {
  String format = 'EEE, d MMM yyyy';

  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    symbol: '$currencySymbol ',
    locale: 'en_IN',
    decimalDigits: 2,
  );

  @override
  void initState() {
    super.initState();

    ref.read(expenseProvider.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    Set dates = ref
        .watch(expenseProvider)
        .map((e) => DateFormat(format).format(e.dateTime!))
        .toSet();

    if (kDebugMode) {
      print(dates);
    }

    Map<String, List<ExpenseEntity>> dateMap = {};

    for (var element in dates) {
      dateMap[element] = ref
          .watch(expenseProvider)
          .where((e) => DateFormat(format).format(e.dateTime!) == element)
          .toList()
          .reversed
          .toList();
    }

    var items = dateMap.entries.toList().reversed;

    return ListView.builder(
      padding: EdgeInsets.zero,
      itemCount: dateMap.length,
      itemBuilder: (context, index) {
        MapEntry<String, List<ExpenseEntity>> expenseMap = items.elementAt(
          index,
        );
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: const BoxDecoration(
                color: Colors.black12,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(4),
                  bottomRight: Radius.circular(4),
                ),
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 4,
              ),
              child: Text(
                expenseMap.key,
                style: context.titleMedium(),
              ),
            ),
            ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: expenseMap.value.length,
              itemBuilder: (context, index) {
                final expense = expenseMap.value[index];
                return ListTile(
                  onLongPress: () =>
                      ref.read(expenseProvider.notifier).removeExpense(expense),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expense.description?.toString() ?? expense.type.name,
                        style: context.titleMedium(),
                      ),
                      Text(
                        formatter.formatDouble(expense.amount),
                        style: context.titleMedium(),
                      ),
                    ],
                  ),
                  subtitle: Text(expense.formattedDate()),
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: expense.type == ExpenseType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    child: const Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                      size: 16,
                    ),
                  ),
                  // trailing: IconButton(
                  //   icon: const Icon(Icons.delete),
                  //   onPressed: () =>
                  //       ref.read(expenseProvider.notifier).removeExpense(
                  //             expense,
                  //           ),
                  // ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
