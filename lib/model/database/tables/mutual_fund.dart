import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';

enum MFType { sip, lumpSum }

enum SipPeriod { daily, monthly, weekly }

class MutualFund extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get fundId => integer()();

  TextColumn get name => text().nullable()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  RealColumn get units => real()();

  RealColumn get nav => real().nullable()();

  RealColumn get currentValue => real().nullable()();

  RealColumn get gainPercentage => real().nullable()();

  TextColumn get type => textEnum<MFType>()();

  TextColumn get period => textEnum<SipPeriod>()();

  DateTimeColumn get investedDate => dateTime().nullable()();

  IntColumn get accountId => integer()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}

class MutualFundQuery {
  Future insert(MutualFundCompanion companion) async {
    return await database
        .into(database.mutualFund)
        .insertOnConflictUpdate(companion);
  }

  Future<List<MutualFundData>> allMutualFunds() async {
    final funds = await database.select(database.mutualFund).get();

    return funds
        .map((e) => MutualFundData(
              id: e.id,
              fundId: e.fundId,
              name: e.name,
              description: e.description,
              amount: e.amount,
              units: e.units,
              type: e.type,
              period: e.period,
              investedDate: e.investedDate,
              accountId: e.accountId,
              isActive: e.isActive,
              nav: e.nav,
              currentValue: e.currentValue,
              gainPercentage: e.gainPercentage,
            ))
        .toList();
  }

  Future delete(int id) async {
    return await database.mutualFund.deleteWhere(
      (tbl) => tbl.id.isValue(id),
    );
  }
}
