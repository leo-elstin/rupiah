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
  Future insert(EMIEntity entity) async {
    var companion = EmiCompanion.insert(
      description: Value(entity.description),
      amount: entity.amount,
      endDate: Value(
        entity.endDate ?? DateTime.now(),
      ),
    );
    return database.into(database.emi).insert(companion);
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