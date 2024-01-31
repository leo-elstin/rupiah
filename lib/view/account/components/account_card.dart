import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

class AccountCard extends StatefulWidget {
  final AccountEntity entity;

  const AccountCard({super.key, required this.entity});

  @override
  State<AccountCard> createState() => _AccountCardState();
}

class _AccountCardState extends State<AccountCard> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.entity.description ?? '',
                            style: context.boldBody(),
                          ),
                          Text(
                            widget.entity.accountName ?? '',
                            style: context.body(),
                          ),
                        ],
                      ),
                      const Icon(
                        Icons.savings_outlined,
                      )
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: widget.entity.accountType == AccountType.savings
                    ? Colors.blue.withOpacity(0.50)
                    : Colors.grey.withOpacity(0.25),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Balance',
                              style: context.small(),
                            ),
                            Text(
                              widget.entity.balance?.toCurrency() ?? 'NA',
                              style: context.boldBody(),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Expense',
                              style: context.small(),
                            ),
                            Text(
                              formatter.formatDouble(0),
                              style: context.boldBody(),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
