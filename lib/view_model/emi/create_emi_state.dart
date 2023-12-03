import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:jiffy/jiffy.dart';

class CreateEMIState extends StateNotifier<EMIEntity> {
  CreateEMIState() : super(const EMIEntity());

  Future addEMI(EMIEntity emi, int count) async {
    EmiData data = await EMITable().insert(emi);

    List<ExpenseCompanion> companion = [];
    List.generate(count, (index) {
      print(index);
      print(Jiffy.now().add(months: index).dateTime);
      companion.add(
        ExpenseCompanion.insert(
          amount: emi.amount,
          type: ExpenseType.outgoing,
          accountId: -1,
          categoryId: -1,
          isEMI: const Value(true),
          emiId: Value(data.id),
          description: Value(emi.description),
          date: Value(Jiffy.now().add(months: index).dateTime),
        ),
      );
    });

    await database.batch(
      (batch) => batch.insertAll(database.expense, companion),
    );
  }

  void updateEMI(EMIEntity emi) {
    state = emi;
  }

  void amount(double amount) {
    if (amount > 0) {
      state = state.copyWith(amount: amount);
    } else {
      state = state.copyWith(amount: null);
    }
  }
}

final emiState = StateNotifierProvider<CreateEMIState, EMIEntity>((ref) {
  return CreateEMIState();
});
