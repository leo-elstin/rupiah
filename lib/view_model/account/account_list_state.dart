import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountListState extends StateNotifier<List<AccountEntity>> {
  AccountListState() : super(const []);

  bool asc = false;

  AccountEntity? selected;

  void setSelected(AccountEntity entity) {
    selected = entity;
    state = [...state];
  }

  Future getAll() async {
    state = await AccountTable().get();
  }

  // void sort() {
  //   asc = !asc;
  //   state = [...state]..sort(
  //       (a, b) =>
  //           asc ? a.amount.compareTo(b.amount) : b.amount.compareTo(a.amount),
  //     );
  // }

  void delete(AccountEntity entity) async {
    await AccountTable().remove(entity);
    await getAll();
  }
}

final accountListState =
    StateNotifierProvider<AccountListState, List<AccountEntity>>((ref) {
  return AccountListState();
});
