import 'dart:convert';

import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/mf_central_entity.dart';
import 'package:expense_kit/model/entity/mf_central_login_entiry.dart';
import 'package:expense_kit/model/service/exceptions.dart';
import 'package:expense_kit/model/service/mutual_fund_service.dart';
import 'package:expense_kit/view_model/savings/savings_cubit.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'mf_login_state.dart';

class MfLoginCubit extends Cubit<MfLoginState> {
  MfLoginCubit({required this.savingsCubit}) : super(MfLoginInitial());

  final SavingsCubit savingsCubit;
  final MutualFundService _service = MutualFundService();

  init() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? login = prefs.getString('mf_login');
    if (login != null) {
      MFCentralEntity entity = MFCentralEntity.fromJson(json.decode(login));
      try {
        PortfolioData? data = await _service.getMFPortfolio(
          mobileNo: entity.mobile,
          pan: entity.pan,
          reqId: entity.reqId,
          token: entity.token,
        );

        if (data != null) {
          for (var value in data.data) {
            Scheme scheme = value.schemes.first;
            final companion = MutualFundCompanion(
              id: Value(int.parse(scheme.folio)),
              fundId: Value(int.parse(scheme.folio)),
              name: Value(scheme.schemeName),
              description: Value(scheme.brokerName),
              amount: Value(double.parse(scheme.costValue)),
              units: Value(double.parse(scheme.availableUnits)),
              type: const Value(MFType.sip),
              period: const Value(SipPeriod.monthly),
              investedDate: Value(DateTime.now()),
              accountId: const Value(-1),
              nav: Value(double.parse(scheme.nav)),
              currentValue: Value(double.parse(scheme.currentMktValue)),
              gainPercentage: Value(double.parse(scheme.gainLossPercentage)),
            );

            await MutualFundQuery().insert(companion);
          }
          savingsCubit.updateMutualFunds(data);
        }
      } on ServiceError catch (e) {
        if (e.code == 401) {
          emit(MFLoginExpired());
        } else {
          emit(MfLoginFailed());
        }
      }
    } else {
      emit(MFNotLoggedIn());
    }
  }

  void setupCredentials(MFCentralEntity entity) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    String string = json.encode(entity.toJson());
    await prefs.setString('mf_login', string);
    init();
  }
}
