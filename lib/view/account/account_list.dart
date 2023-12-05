import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/view/account/add_account.dart';
import 'package:expense_kit/view/account/components/account_card.dart';
import 'package:expense_kit/view_model/account/account_list_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AccountsList extends ConsumerStatefulWidget {
  static const route = '/accounts';

  const AccountsList({super.key});

  @override
  ConsumerState<AccountsList> createState() => _AccountsListState();
}

class _AccountsListState extends ConsumerState<AccountsList> {
  @override
  void initState() {
    super.initState();
    ref.read(accountListState.notifier).getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accounts'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.push(AddAccount.route),
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        itemCount: ref.watch(accountListState).length,
        itemBuilder: (context, index) {
          AccountEntity entity = ref.watch(accountListState)[index];
          return InkWell(
            onLongPress: () {
              ref.read(accountListState.notifier).delete(entity);
            },
            child: AccountCard(
              entity: entity,
            ),
          );
        },
      ),
    );
  }
}
