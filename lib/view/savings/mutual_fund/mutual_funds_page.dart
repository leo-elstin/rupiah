import 'package:expense_kit/view/savings/mutual_fund/mutual_fund_item.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';

class MutualFundPage extends StatefulWidget {
  static const route = '/mutual-fund';
  const MutualFundPage({super.key});

  @override
  StateModel<MutualFundPage, SavingsCubit> createState() =>
      _MutualFundPageState();
}

class _MutualFundPageState extends StateModel<MutualFundPage, SavingsCubit> {
  @override
  void initView(SavingsCubit cubit) {
    super.initView(cubit);
  }

  @override
  Widget buildMobile(BuildContext context, SavingsCubit cubit) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Funds'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
      body: ListView.separated(
        itemCount: cubit.funds.length,
        itemBuilder: (BuildContext context, int index) {
          return MutualFundItem(
            fund: cubit.funds[index],
          );
        },
        separatorBuilder: (BuildContext context, int index) {
          return const Divider(
            thickness: 0.5,
          );
        },
      ),
    );
  }
}
