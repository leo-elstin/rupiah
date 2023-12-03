import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateAccountState extends StateNotifier<AccountEntity> {
  CreateAccountState() : super(AccountEntity());

  final AccountTable _table = AccountTable();

  Future addAccount(AccountEntity entity) {
    return _table.insert(entity);
  }

  void updateAccount(AccountEntity entity) {
    state = entity;
  }
}

final createAccountState =
    StateNotifierProvider<CreateAccountState, AccountEntity>((ref) {
  return CreateAccountState();
});
