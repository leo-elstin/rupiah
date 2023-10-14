import 'package:expense_kit/view/account/components/account_card.dart';
import 'package:flutter/material.dart';

class AccountsList extends StatelessWidget {
  static const route = '/accounts';

  const AccountsList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      body: ListView.builder(
        itemCount: 2,
        itemBuilder: (context, index) {
          return const AccountCard();
        },
      ),
    );
  }
}
