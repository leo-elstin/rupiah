import 'package:bloc/bloc.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:meta/meta.dart';

part 'mutual_fund_state.dart';

class MutualFundCubit extends Cubit<MutualFundState> {
  MutualFundCubit() : super(MutualFundInitial());

  final _service = MutualFundService();

  List<Scheme> _masterFunds = [];
  List<Scheme> _funds = [];

  List<Scheme> get funds => _funds;

  void searchFund(String query) {
    emit(MutualFundLoading());
    _funds = _masterFunds
        .where(
          (element) => element.schemeName
              .replaceAll('-', ' ')
              .toLowerCase()
              .contains(query.toLowerCase()),
        )
        .toList();
    emit(MutualFundLoaded());
  }

  void clear() {
    _funds.clear();
  }

  void loadFunds() async {
    if (_masterFunds.isNotEmpty) {
      _funds = _masterFunds;
      emit(MutualFundLoaded());
      return;
    }
    emit(MutualFundLoading());
    _masterFunds = await _service.getFunds();
    _funds = _masterFunds;
    emit(MutualFundLoaded());
  }
}
