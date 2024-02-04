import 'package:drift/drift.dart';
import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:expense_kit/model/database/database.dart';

class Investment extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  DateTimeColumn get endDate => dateTime().nullable()();

  IntColumn get type => intEnum<InvestmentType>()();
}

class InvestmentQuery {
  Future insert(InvestmentCompanion companion) async {
    return await database.into(database.investment).insert(companion);
  }

  // Future remove(InvestmentCompanion companion) async {
  //   return database.into(database.investment).wh;
  // }

  Future<List<InvestmentData>> allInvestments() async {
    final investments = await database.select(database.investment).get();

    return investments
        .map((e) => InvestmentData(
              id: e.id,
              description: e.description,
              amount: e.amount,
              endDate: e.endDate,
              type: e.type,
            ))
        .toList();
  }
}
