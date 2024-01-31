import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/account/add_account.dart';
import 'package:expense_kit/view/category/add_category.dart';
import 'package:expense_kit/view/components/add_button.dart';
import 'package:expense_kit/view/components/custom_icon.dart';
import 'package:expense_kit/view/decorations.dart';
import 'package:expense_kit/view_model/account/account_list_state.dart';
import 'package:expense_kit/view_model/category/category_cubit.dart';
import 'package:expense_kit/view_model/create_expense.dart';
import 'package:expense_kit/view_model/expense_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class AddExpense extends ConsumerStatefulWidget {
  static const route = '/add-expense';

  final ExpenseEntity? expenseEntity;

  const AddExpense({super.key, this.expenseEntity});

  @override
  ConsumerState<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends ConsumerState<AddExpense> {
  TextEditingController dateController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController amountController = TextEditingController();
  final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
    symbol: '${CurrencyUtils.currencySymbol} ',
    locale: 'en_IN',
  );

  DateFormat dateFormat = DateFormat('dd MMM, yy h:mm aa');

  @override
  void initState() {
    super.initState();

    ref.read(accountListState.notifier).getAll();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.expenseEntity != null) {
        ref.invalidate(createExpense);
        ref.read(createExpense.notifier).updateExpense(widget.expenseEntity!);

        dateController.text = dateFormat.format(
          widget.expenseEntity!.dateTime!,
        );
        descriptionController.text = widget.expenseEntity!.description ?? '';
        amountController.text = formatter.formatDouble(
          widget.expenseEntity!.amount * 100,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
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
                controller: amountController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
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
                    mode: CupertinoDatePickerMode.dateAndTime,
                    use24hFormat: true,
                    // This shows day of week alongside day of month
                    showDayOfWeek: true,
                    // This is called when the user changes the date.
                    onDateTimeChanged: (DateTime newDate) {
                      dateController.text = dateFormat.format(
                        newDate,
                      );
                      ref.read(createExpense.notifier).updateExpense(
                            expense.copyWith(dateTime: newDate),
                          );
                    },
                  ),
                ),
                style: context.titleMedium(),
                readOnly: true,
                decoration: textDecoration.copyWith(
                  labelText: 'Date & Time',
                  hintText: DateFormat('dd MMM, yy h:mm aa').format(
                    DateTime.now(),
                  ),
                  labelStyle: context.titleLarge(),
                ),
              ),
              const SizedBox(height: 32),
              TextField(
                  controller: descriptionController,
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
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  children: [
                    AddButton(
                      onTap: () => context.push(AddAccount.route),
                      width: 75,
                      height: 75,
                    ),
                    ...ref.watch(accountListState).map((entity) {
                      return InkWell(
                        onTap: () {
                          ref
                              .read(createExpense.notifier)
                              .updateExpense(expense.copyWith(
                                accountId: entity.id,
                              ));
                        },
                        child: Container(
                          constraints: const BoxConstraints(
                            minWidth: 125,
                            maxWidth: 200,
                          ),
                          height: 75,
                          child: Card(
                            shape: RoundedRectangleBorder(
                              side: BorderSide(
                                color: expense.accountId == entity.id
                                    ? Theme.of(context).colorScheme.primary
                                    : Theme.of(context)
                                        .colorScheme
                                        .surfaceVariant,
                              ),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(4),
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(entity.accountName ?? ''),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          entity.description ?? '',
                                          style: context.boldBody(),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.blue,
                                          borderRadius: BorderRadius.circular(
                                            2,
                                          ),
                                        ),
                                        padding: const EdgeInsets.symmetric(
                                          vertical: 1,
                                          horizontal: 4,
                                        ),
                                        child: Text(
                                          entity.accountType.name.capitalize(),
                                          style: context.smaller()?.copyWith(
                                                color: Colors.white,
                                              ),
                                        ),
                                      )
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    })
                  ],
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Category',
                style: context.body(),
              ),
              BlocBuilder<CategoryCubit, CategoryState>(
                builder: (context, state) {
                  return Wrap(
                    children: [
                      AddButton(
                        horizontal: true,
                        onTap: () {
                          showModalBottomSheet(
                            isScrollControlled: true,
                            context: context,
                            builder: (context) => const AddCategory(),
                          );
                        },
                        width: 75,
                        height: null,
                      ),
                      ...context
                          .read<CategoryCubit>()
                          .list
                          .map(
                            (e) => Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 4),
                              child: InkWell(
                                onTap: () {
                                  ref
                                      .read(createExpense.notifier)
                                      .updateExpense(expense.copyWith(
                                        categoryId: e.id,
                                      ));
                                },
                                child: Chip(
                                  side: BorderSide(
                                    color: expense.categoryId == e.id
                                        ? Theme.of(context).colorScheme.primary
                                        : Theme.of(context)
                                            .colorScheme
                                            .surfaceVariant,
                                  ),
                                  avatar: CustomIcon(
                                    iconCode: e.iconCode,
                                  ),
                                  label: Text(e.name),
                                  elevation: 4,
                                ),
                              ),
                            ),
                          )
                          .toList()
                    ],
                  );
                },
              ),
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
                  onPressed: expense.amount > 0 && expense.accountId != null
                      ? () {
                          if (widget.expenseEntity == null) {
                            ref
                              ..read(expenseProvider.notifier).add(expense)
                              ..invalidate(createExpense);
                          } else {
                            ref
                              ..read(expenseProvider.notifier).update(expense)
                              ..invalidate(createExpense);
                          }

                          context.pop();
                        }
                      : null,
                  child: widget.expenseEntity == null
                      ? const Text('Add Expense')
                      : const Text('Update Expense'),
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
