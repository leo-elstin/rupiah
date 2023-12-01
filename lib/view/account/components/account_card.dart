import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/extensions.dart';
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
    final MaterialStateProperty<Icon?> thumbIcon =
        MaterialStateProperty.resolveWith<Icon?>(
      (Set<MaterialState> states) {
        if (states.contains(MaterialState.selected)) {
          return const Icon(Icons.check);
        }
        return null;
      },
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: widget.entity.accountName!.contains('ICICI')
            ? Theme.of(context).colorScheme.surfaceVariant
            : Colors.green.shade100,
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
                        color: Colors.purple,
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatter.formatDouble(widget.entity.balance ?? 0),
                        style: context.titleMedium(),
                      ),
                      SizedBox(
                        height: 32,
                        child: FittedBox(
                          fit: BoxFit.fill,
                          child: Switch(
                            thumbIcon: thumbIcon,
                            value: selected,
                            onChanged: (value) {
                              setState(() {
                                selected = value;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.withOpacity(0.2),
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(8),
                  bottomRight: Radius.circular(8),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'This Month',
                    style: context.body(),
                  ),
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
                              'Income',
                              style: context.small(),
                            ),
                            Text(
                              formatter.formatDouble(125000),
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
