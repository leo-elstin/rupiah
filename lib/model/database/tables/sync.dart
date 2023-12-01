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
}
