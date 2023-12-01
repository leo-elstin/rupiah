import 'dart:convert';

import 'package:appwrite/appwrite.dart';
import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/database/tables/sync.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccountState extends StateNotifier<AccountEntity> {
  CreateAccountState() : super(AccountEntity());

  final AccountTable _table = AccountTable();

  Future addAccount(AccountEntity entity) async {
    AccountEntity temp = entity.copyWith(
      id: ID.unique(),
    );
    await SyncTable().insert(
      data: jsonEncode(temp.toMap()),
      type: TableType.account,
    );
    return _table.insert(temp);
  }

  void updateAccount(AccountEntity entity) {
    state = entity;
  }
}

final createAccountState =
    StateNotifierProvider<CreateAccountState, AccountEntity>((ref) {
  return CreateAccountState();
});
