import 'package:expense_kit/utils/ui_extensions.dart';
import 'package:expense_kit/view/emi/loan_card.dart';
import 'package:expense_kit/view/expense/balance_card.dart';
import 'package:expense_kit/view/savings/savings_details.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:expense_kit/view_model/emi/emi_list_state.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  StateModel<Dashboard, DashboardCubit> createState() => _DashboardState();
}

class _DashboardState extends StateModel<Dashboard, DashboardCubit> {
  @override
  void initView(DashboardCubit cubit) {
    cubit.expense();

    super.initView(cubit);
  }

  @override
  Widget buildMobile(BuildContext context, DashboardCubit cubit) {
    return Scaffold(
      body: ListView(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("MY ASSETS"),
                const SizedBox(
                  height: 8,
                ),
                Consumer(
                  // 2. specify the builder and obtain a WidgetRef
                  builder: (_, WidgetRef ref, __) {
                    // 3. use ref.watch() to get the value of the provider
                    final provider = ref.read(emiListProvider.notifier);
                    return Text(
                      (cubit.balance - provider.pending()).toCurrency(),
                      style: const TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
          const BalanceCard(),
          const LoanCard(),
          const SavingsDetails(),
        ],
      ),
    );
  }
}
