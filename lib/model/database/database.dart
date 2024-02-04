import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:expense_kit/features/investment/model/investment_model.dart';
import 'package:expense_kit/model/database/tables/account.dart';
import 'package:expense_kit/model/database/tables/category_table.dart';
import 'package:expense_kit/model/database/tables/emi.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/database/tables/investment.dart';
import 'package:expense_kit/model/database/tables/mutual_fund.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

part 'database.g.dart';

final database = Database();

@DriftDatabase(tables: [
  Expense,
  Emi,
  CategoryDb,
  Account,
  Investment,
  MutualFund,
])
class Database extends _$Database {
  Database() : super(_openConnection());

  @override
  int get schemaVersion => 10;

  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          // we added the dueDate property in the change from version 1 to
          // version 2
          await m.addColumn(expense, expense.isEMI);
          await m.addColumn(expense, expense.emiId);
        }

        if (from < 4) {
          await m.createTable(database.mutualFund);
        }
        if (from < 6) {
          await m.addColumn(mutualFund, mutualFund.currentValue);
          await m.addColumn(mutualFund, mutualFund.gainPercentage);
        }
        if (from < 9) {
          await m.addColumn(mutualFund, mutualFund.nav);
        }
        if (from < 10) {
          await m.addColumn(account, account.accountType);
        }
      },
    );
  }
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
