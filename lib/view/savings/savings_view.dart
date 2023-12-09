import 'package:expense_kit/view/savings/savings_details.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:expense_kit/view_model/state_vm.dart';
import 'package:flutter/material.dart';

class SavingView extends StatefulWidget {
  const SavingView({super.key});

  @override
  StateModel<SavingView, SavingsCubit> createState() => _SavingViewState();
}

class _SavingViewState extends StateModel<SavingView, SavingsCubit> {
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
      body: const SingleChildScrollView(
        child: Column(
          children: [
            SavingsDetails(),
          ],
        ),
      ),
    );
  }
}
