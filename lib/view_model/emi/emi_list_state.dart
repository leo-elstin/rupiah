import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EMIListState extends StateNotifier<List<EMIEntity>> {
  EMIListState() : super(const []);

  bool asc = false;

  double totalAmount() {
    return state.fold(
        0, (previousValue, element) => previousValue + element.amount);
  }

  Future getAll() async {
    state = await EMITable().get();
  }

  void sort() {
    asc = !asc;
    state = [...state]..sort(
        (a, b) =>
            asc ? a.amount.compareTo(b.amount) : b.amount.compareTo(a.amount),
      );
  }

  double pending() {
    return state.fold(
        0, (previousValue, element) => previousValue + element.pending());
  }

  void delete(EMIEntity entity) async {
    await EMITable().remove(entity);
    await ExpenseTable().removeByEMI(entity.id!);
    await getAll();
  }
}

final emiListProvider =
    StateNotifierProvider<EMIListState, List<EMIEntity>>((ref) {
  return EMIListState()..getAll();
});
