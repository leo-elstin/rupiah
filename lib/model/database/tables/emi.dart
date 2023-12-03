import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/entity/emi_entity.dart';

class Emi extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  DateTimeColumn get endDate => dateTime().nullable()();
}

class EMITable {
  Future<EmiData> insert(EMIEntity entity) async {
    var companion = EmiCompanion.insert(
      description: Value(entity.description),
      amount: entity.amount,
      endDate: Value(
        entity.endDate ?? DateTime.now(),
      ),
    );

    return database.into(database.emi).insertReturning(companion);
  }

  Future remove(EMIEntity entity) async {
    return database.emi.deleteWhere((tbl) => tbl.id.isValue(entity.id!));
  }

  Future<List<EMIEntity>> get() async {
    final emiList = await database.select(database.emi).get();

    return emiList
        .map((e) => EMIEntity(
              id: e.id,
              description: e.description,
              amount: e.amount,
              endDate: e.endDate,
            ))
        .toList();
  }
}
