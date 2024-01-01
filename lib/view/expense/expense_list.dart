import 'package:collection/collection.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/category_entiry.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/components/custom_icon.dart';
import 'package:expense_kit/view/expense/add_expense.dart';
import 'package:expense_kit/view_model/category/category_cubit.dart';
import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class ExpenseList extends ConsumerStatefulWidget {
  const ExpenseList({super.key});

  @override
  ConsumerState<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends ConsumerState<ExpenseList> {
  String format = 'MMM, yyyy';

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

    List<CategoryEntity> categories = context.read<CategoryCubit>().list;

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
                CategoryEntity? category = categories.firstWhereOrNull(
                  (element) => element.id == expense.categoryId,
                );
                return ListTile(
                  dense: true,
                  onTap: () {},
                  onLongPress: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) => CupertinoActionSheet(
                        actions: [
                          CupertinoActionSheet(
                            title: Text(
                              formatter.formatDouble(expense.amount),
                            ),
                            message: const Text(
                              'Deletion is a permanent action.',
                            ),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              HapticFeedback.lightImpact();
                              context
                                ..push(AddExpense.route, extra: expense)
                                ..pop();
                            },
                            child: const Text('Edit'),
                          ),
                          CupertinoActionSheetAction(
                            onPressed: () {
                              ref.read(expenseProvider.notifier).removeExpense(
                                    expense,
                                  );
                              Navigator.pop(context);
                              HapticFeedback.heavyImpact();
                            },
                            isDestructiveAction: true,
                            child: const Text('Delete'),
                          ),
                        ],
                        cancelButton: CupertinoActionSheetAction(
                          onPressed: () {
                            HapticFeedback.lightImpact();
                            Navigator.pop(context);
                          },
                          child: const Text('Cancel'),
                        ),
                      ),
                    );
                    HapticFeedback.mediumImpact();
                  },
                  title: Row(
                    children: [
                      Expanded(
                        child: Text(
                          expense.description?.toString() ?? expense.type.name,
                          style: context.titleSmall(),
                        ),
                      ),
                      Expanded(
                        child: Text(
                          formatter.formatDouble(expense.amount),
                          textAlign: TextAlign.end,
                          style: context.titleMedium(),
                        ),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        expense.formattedDate(),
                        style: context.small(),
                      ),
                      const SizedBox(width: 8),
                      if (category != null)
                        Container(
                          padding: const EdgeInsets.only(
                            right: 8,
                            top: 2,
                            bottom: 2,
                            left: 4,
                          ),
                          decoration: BoxDecoration(
                            color: category.colorCode == null
                                ? Colors.white24
                                : Color(int.parse(category.colorCode!)),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Row(
                            children: [
                              CustomIcon(
                                iconCode: category.iconCode,
                                size: 14,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                category.name,
                                style: context.small(),
                              ),
                            ],
                          ),
                        ),
                    ],
                  ),
                  leading: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: expense.type == ExpenseType.income
                          ? Colors.green
                          : Colors.red,
                    ),
                    child: const Icon(
                      Icons.currency_rupee,
                      color: Colors.white,
                      size: 14,
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
