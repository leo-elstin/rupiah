import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CreateEMIState extends StateNotifier<EMIEntity> {
  CreateEMIState() : super(const EMIEntity());

  Future addEMI(EMIEntity emi) async {
    await EMITable().insert(emi);
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
