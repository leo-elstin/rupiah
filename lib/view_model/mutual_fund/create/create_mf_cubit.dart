import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/mutual_fund.dart';
import 'package:expense_kit/model/entity/scheme_entity.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'create_mf_state.dart';

class CreateMfCubit extends Cubit<CreateMfState> {
  CreateMfCubit() : super(CreateMfInitial());

  final MutualFundQuery _query = MutualFundQuery();

  num? _amount;
  num? _currentValue;
  MFType _type = MFType.sip;
  Scheme? _scheme;
  MutualFundEntity? fund;

  // setters
  set amount(num? value) {
    _amount = value;
    emit(FiledUpdated());
  }

  set currentValue(num? value) {
    _currentValue = value;
    emit(FiledUpdated());
  }

  set type(MFType value) {
    _type = value;
    emit(FiledUpdated());
  }

  set scheme(Scheme? value) {
    _scheme = value;
    emit(FiledUpdated());
  }

  // getters
  num? get amount => _amount;

  num? get currentValue => _currentValue;

  MFType get type => _type;

  Scheme? get scheme => _scheme;

  bool get isValid =>
      _amount != null &&
      _currentValue != null &&
      _scheme != null &&
      fund != null;

  /// Methods

  void insert() async {
    if (isValid) {
      var units = _currentValue!.toDouble() / fund!.currentNav;
      final companion = MutualFundCompanion(
        fundId: Value(_scheme!.schemeCode),
        name: Value(_scheme!.schemeName),
        description: Value(_scheme!.schemeName),
        amount: Value(_amount!.toDouble()),
        units: Value(units),
        type: Value(_type),
        period: const Value(SipPeriod.monthly),
        investedDate: Value(DateTime.now()),
        accountId: const Value(-1),
      );

      await _query.insert(companion);
    }
  }

  void fundDetails() async {
    fund = await MutualFundService().getDetails(
      _scheme!.schemeCode.toString(),
    );
    emit(FundDetailsLoaded());
  }
}
