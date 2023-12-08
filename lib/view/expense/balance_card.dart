import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:expense_kit/model/entity/expense_card_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view_model/expense_card_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final CurrencyTextInputFormatter formatter = CurrencyTextInputFormatter(
  symbol: '$currencySymbol ',
  locale: 'en_IN',
  decimalDigits: 2,
);

class BalanceCard extends ConsumerWidget {
  const BalanceCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ExpenseCardEntity value = ref.watch(expenseCardState);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'ACCOUNTS BALANCE',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatter.formatDouble(value.totalBalance),
                    style: context.titleLarge(),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              const Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Income',
                        ),
                        SizedBox(width: 16),
                        Icon(
                          Icons.trending_up,
                          color: Colors.green,
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Text(
                          'Expense',
                        ),
                        SizedBox(width: 16),
                        Icon(
                          Icons.trending_down,
                          color: Colors.red,
                        )
                      ],
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '+ ${formatter.formatDouble(value.income)}',
                      style: context.titleMedium(),
                    ),
                  ),
                  Expanded(
                    child: Text(
                      '- ${formatter.formatDouble(value.expense)}',
                      style: context.titleMedium(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
