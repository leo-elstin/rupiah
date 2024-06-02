import 'package:expense_kit/features/funds/view/mutual_funds_page.dart';
import 'package:expense_kit/features/investment/view/add_investment.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SavingList extends StatefulWidget {
  const SavingList({super.key});

  @override
  StateModel<SavingList, SavingsCubit> createState() => _SavingListState();
}

class _SavingListState extends StateModel<SavingList, SavingsCubit> {
  @override
  Widget buildMobile(BuildContext context, SavingsCubit cubit) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        GridView(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            InkWell(
              onTap: () => context.push(MutualFundPage.route),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/rupee.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Mutual Funds',
                      style: context.smaller(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cubit.mutualFundBalance.toCurrency(),
                      style: context.smallBold(),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/trend.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Stocks',
                    style: context.smaller(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cubit.stockBalance.toCurrency(),
                    style: context.smallBold(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/gold-ingot.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Gold',
                    style: context.smaller(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cubit.goldBalance.toCurrency(),
                    style: context.smallBold(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Image.asset(
                    'assets/icons/epf.png',
                    width: 32,
                    height: 32,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'EPF',
                    style: context.smaller(),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cubit.epfBalance.toCurrency(),
                    style: context.smallBold(),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: InkWell(
                onTap: () => showModalBottomSheet(
                  isScrollControlled: true,
                  context: context,
                  builder: (context) => const AddInvestment(),
                ),
                child: Column(
                  children: [
                    Image.asset(
                      'assets/icons/market.png',
                      width: 32,
                      height: 32,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Real Estate',
                      style: context.smaller(),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      cubit.realEstateBalance.toCurrency(),
                      style: context.smallBold(),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
