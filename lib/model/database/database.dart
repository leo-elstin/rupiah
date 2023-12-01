import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/database/tables/category.dart';
import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/database/tables/sync.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

final database = Database();

@DriftDatabase(tables: [Expense, Emi, CategoryDb, Account, Sync])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 1; // bump because the tables have changed.

  // @override
  // MigrationStrategy get migration {
  //   return MigrationStrategy(
  //     onCreate: (Migrator m) async {
  //       await m.createAll();
  //     },
  //     onUpgrade: (Migrator m, int from, int to) async {
  //       if (from < 2) {
  //
  //       }
  //     },
  //   );
  // }
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(p.join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase.createInBackground(file);
  });
}
