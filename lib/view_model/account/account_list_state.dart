import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/entity/account_entity.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AccountListState extends StateNotifier<List<AccountEntity>> {
  AccountListState() : super(const []);

  bool asc = false;

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

  void delete(EMIEntity entity) {
    EMITable().remove(entity);
    state = state.where((e) => e.id != entity.id).toList();
  }
}

final accountListState =
    StateNotifierProvider<AccountListState, List<AccountEntity>>((ref) {
  return AccountListState();
});
