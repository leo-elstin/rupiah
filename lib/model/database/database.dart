import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

final database = Database();

@DriftDatabase(tables: [Expense])
class Database extends _$Database {
  Database() : super(_openConnection());
  @override
  int get schemaVersion => 1;
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
