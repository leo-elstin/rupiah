import 'package:expense_kit/features/funds/view_model/mutual_fund_cubit.dart';
import 'package:expense_kit/utils/currency_utils.dart';
import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/savings/savings_list.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SavingsDetails extends StatefulWidget {
  const SavingsDetails({super.key});

  @override
  StateModel<SavingsDetails, SavingsCubit> createState() => _SavingsDetailsState();
}

class _SavingsDetailsState extends StateModel<SavingsDetails, SavingsCubit> {
  @override
  void initView(SavingsCubit cubit) {
    context.read<MutualFundCubit>().get();
    super.initView(cubit);
  }

  @override
  Widget buildMobile(BuildContext context, SavingsCubit cubit) {
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
                    'INVESTMENTS',
                  ),
                  const SizedBox(height: 4),
                  Text(
                    cubit.total.toCurrency(),
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
                          'Invested',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            'Gain/Loss',
                          ),
                        ),
                        SizedBox(width: 8),
                        Expanded(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: RotatedBox(
                              quarterTurns: 3,
                              child: Icon(
                                Icons.play_arrow_sharp,
                                color: Colors.green,
                                size: 18,
                              ),
                            ),
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
                      formatter.formatDouble(cubit.invested),
                      style: context.titleMedium(),
                    ),
                  ),
                  Expanded(
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          flex: 2,
                          child: Text(
                            formatter.formatDouble(cubit.profit),
                            style: context.titleMedium(),
                          ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        Expanded(
                          child: Text(
                            '${cubit.profitPercentage.toStringAsFixed(1)}%',
                            style: context.smallBold()?.copyWith(
                                  color: Colors.green,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SavingList(),
            ],
          ),
        ),
      ),
    );
  }
}
