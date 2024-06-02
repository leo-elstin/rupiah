import 'package:expense_kit/features/funds/model/mutual_fund_model.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:flutter/material.dart';

class MutualFundItem extends StatelessWidget {
  final MutualFundModel fund;
  final VoidCallback onTap;

  const MutualFundItem({
    super.key,
    required this.fund,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onLongPress: onTap,
      child: Container(
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
                // if (fund.logoPath != '')
                //   ClipRRect(
                //     borderRadius: BorderRadius.circular(45),
                //     child: Image.network(
                //       fund.logoPath,
                //       width: 24,
                //     ),
                //   )
                // else
                //   const SizedBox(
                //     width: 24,
                //     height: 24,
                //   ),
                const SizedBox(
                  width: 16,
                ),
                Expanded(
                  child: Text(
                    fund.name,
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
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const SizedBox(
                        width: 16,
                      ),
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
                    fund.investedAmount,
                    style: context.mediumBold(),
                  ),
                ),
                Expanded(
                  child: Text(
                    fund.currentAmount,
                    style: context.mediumBold(),
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(width: 16),
                      Text(
                        fund.percentage,
                        style: context.mediumBold(),
                      ),
                      // Text(
                      //   '    ${fund.profitPercent.toStringAsFixed(2)}%',
                      //   style: context.smallerBold()?.copyWith(
                      //         color: Colors.green,
                      //       ),
                      // ),
                    ],
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
