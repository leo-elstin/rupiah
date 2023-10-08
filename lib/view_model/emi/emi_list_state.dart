import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class EMIListState extends StateNotifier<List<EMIEntity>> {
  EMIListState() : super(const []);

  Future getAll() async {
    state = await EMITable().get();
  }
}

final emiListState =
    StateNotifierProvider<EMIListState, List<EMIEntity>>((ref) {
  return EMIListState();
});
