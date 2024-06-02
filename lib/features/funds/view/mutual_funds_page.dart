import 'package:expense_kit/features/funds/view/mutual_fund_item.dart';
import 'package:expense_kit/features/funds/view_model/mutual_fund_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';

class MutualFundPage extends StatefulWidget {
  static const route = '/mutual-fund';

  const MutualFundPage({super.key});

  @override
  StateModel<MutualFundPage, MutualFundCubit> createState() => _MutualFundPageState();
}

class _MutualFundPageState extends StateModel<MutualFundPage, MutualFundCubit> {
  @override
  void initView(MutualFundCubit cubit) {
    cubit.get();
    super.initView(cubit);
  }

  @override
  void listener(state) {
    super.listener(state);
  }

  @override
  Widget buildMobile(BuildContext context, MutualFundCubit cubit) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mutual Funds'),
      ),
      body: ListView.separated(
        itemCount: cubit.funds.length,
        itemBuilder: (BuildContext context, int index) {
          return MutualFundItem(
            fund: cubit.funds[index],
            onTap: () {},
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
