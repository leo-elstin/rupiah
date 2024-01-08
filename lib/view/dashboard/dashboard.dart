import 'package:expense_kit/view/expense/balance_card.dart';
import 'package:expense_kit/view/savings/savings_details.dart';
import 'package:expense_kit/view_model/dashboard/dashboard_cubit.dart';
import 'package:expense_kit/view_model/mutual_fund/mf_login/mf_login_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  StateModel<Dashboard, DashboardCubit> createState() => _DashboardState();
}

class _DashboardState extends StateModel<Dashboard, DashboardCubit> {
  @override
  void initView(DashboardCubit cubit) {
    cubit.expense();

    // init mf login cubit
    context.read<MfLoginCubit>().init();
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
                Text(
                  cubit.totalAmount(),
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const BalanceCard(),
          const SavingsDetails(),
        ],
      ),
    );
  }
}
