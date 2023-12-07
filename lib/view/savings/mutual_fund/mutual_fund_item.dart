import 'package:expense_kit/model/entity/fund_detail.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

class MutualFundItem extends StatelessWidget {
  final FundDetails fund;

  const MutualFundItem({
    super.key,
    required this.fund,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        children: [
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(45),
                child: Image.network(
                  fund.logoPath,
                  width: 24,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Expanded(
                child: Text(
                  fund.fund.meta.schemeName.toUpperCase(),
                  style: context.smaller(),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  'Invested',
                  style: context.smaller()?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              Expanded(
                child: Text(
                  'Current Value',
                  style: context.smaller()?.copyWith(
                        color: Colors.grey,
                      ),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Gain/Loss',
                      style: context.smaller()?.copyWith(
                            color: Colors.grey,
                          ),
                    ),
                    const SizedBox(
                      width: 8,
                    ),
                    const RotatedBox(
                      quarterTurns: 3,
                      child: Icon(
                        Icons.play_arrow_sharp,
                        size: 14,
                        color: Colors.green,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Row(
            children: [
              Expanded(
                child: Text(
                  formatter.formatDouble(
                    fund.invested,
                  ),
                  style: context.mediumBold(),
                ),
              ),
              Expanded(
                child: Text(
                  formatter.formatDouble(
                    fund.units * fund.fund.currentNav,
                  ),
                  style: context.mediumBold(),
                ),
              ),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      formatter.formatDouble(fund.profit),
                      style: context.mediumBold(),
                    ),
                    Text(
                      '    ${fund.profitPercent.toStringAsFixed(2)}%',
                      style: context.smallerBold()?.copyWith(
                            color: Colors.green,
                          ),
                    ),
                  ],
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
