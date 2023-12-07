import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/savings/mutual_fund/mutual_funds_page.dart';
import 'package:expense_kit/view/savings/savings_details.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class SavingView extends StatefulWidget {
  const SavingView({super.key});

  @override
  StateModel<SavingView, SavingsCubit> createState() => _SavingViewState();
}

class _SavingViewState extends StateModel<SavingView, SavingsCubit> {
  @override
  void initView(SavingsCubit cubit) {
    cubit.getFunds();
    super.initView(cubit);
  }

  @override
  Widget buildMobile(BuildContext context, SavingsCubit cubit) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Savings'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SavingsDetails(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Investments',
                        style: context.titleMedium(),
                      ),
                      GridView(
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
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
                                    cubit.mutualFundString,
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
                                  '$currencySymbol ${NumberFormat.compactCurrency(symbol: '', locale: 'en_IN').format(
                                    14300,
                                  )}',
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
                                  '$currencySymbol ${NumberFormat.compactCurrency(symbol: '', locale: 'en_IN').format(
                                    2720000,
                                  )}',
                                  style: context.smallBold(),
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
