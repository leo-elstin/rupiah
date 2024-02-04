import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view_model/emi/emi_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoanCard extends ConsumerWidget {
  const LoanCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<EMIEntity> loans = ref.watch(emiListProvider);
    var notifier = ref.read(emiListProvider.notifier);
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
                    'Debt',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    formatter.formatDouble(notifier.pending()),
                    style: context.titleLarge(),
                  ),
                ],
              ),
              const Divider(),
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: loans.length,
                itemBuilder: (context, index) {
                  EMIEntity entity = loans[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  entity.description ?? 'Loan ${index + 1}',
                                  style: context.smallBold(),
                                ),
                                const SizedBox(height: 3),
                                Text(
                                  formatter.formatDouble(entity.amount),
                                  style: context.small(),
                                ),
                              ],
                            ),
                            Text(
                              entity.pending().toCurrency(),
                              style: context.mediumBold()?.copyWith(
                                    color: Colors.red,
                                  ),
                            ),
                          ],
                        ),
                        Text(
                          '${entity.pendingMonths()} months emi pending',
                          style: context.smaller()?.copyWith(
                                color: Colors.grey.withOpacity(0.5),
                              ),
                        ),
                      ],
                    ),
                  );
                },
              ),

              // const SizedBox(height: 16),
              // const Row(
              //   children: [
              //     Expanded(
              //       child: Row(
              //         children: [
              //           Text(
              //             'Income',
              //           ),
              //           SizedBox(width: 16),
              //           Icon(
              //             Icons.trending_up,
              //             color: Colors.green,
              //           )
              //         ],
              //       ),
              //     ),
              //     Expanded(
              //       child: Row(
              //         children: [
              //           Text(
              //             'Expense',
              //           ),
              //           SizedBox(width: 16),
              //           Icon(
              //             Icons.trending_down,
              //             color: Colors.red,
              //           )
              //         ],
              //       ),
              //     ),
              //   ],
              // ),
              // Row(
              //   children: [
              //     Expanded(
              //       child: Text(
              //         '+ ${formatter.formatDouble(value.income)}',
              //         style: context.titleMedium(),
              //       ),
              //     ),
              //     Expanded(
              //       child: Text(
              //         '- ${formatter.formatDouble(value.expense)}',
              //         style: context.titleMedium(),
              //       ),
              //     ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
