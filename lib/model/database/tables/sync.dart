import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';

enum TableType {
  account,
  emi,
  expense,
  category,
}

class Sync extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get name => text()();

  IntColumn get type => intEnum<TableType>()();

  DateTimeColumn get createdAt => dateTime()();

  BoolColumn get synced => boolean().withDefault(const Constant(false))();
}

class SyncTable {
  Future insert({required String data, required TableType type}) async {
    var companion = SyncCompanion.insert(
      name: data,
      type: type,
      createdAt: DateTime.now(),
    );
    return database.into(database.sync).insert(companion);
  }

  Future<List<SyncData>> get() async {
    return database.select(database.sync).get();
  }

  Future delete(int id) async {
    return database.sync.deleteWhere(
      (tbl) => tbl.id.isValue(id),
    );
  }

  Future clear() async {
    return database.delete(database.sync).go();
  }
}
