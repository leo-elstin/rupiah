import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';

class Expense extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  IntColumn get type => intEnum<ExpenseType>()();

  DateTimeColumn get date => dateTime().nullable()();
}

class ExpenseTable {
  Future insert(ExpenseEntity entity) async {
    var companion = ExpenseCompanion.insert(
      description: Value(entity.description),
      amount: entity.amount,
      type: entity.type,
      date: Value(
        entity.dateTime ?? DateTime.now(),
      ),
    );
    return database.into(database.expense).insert(companion);
  }

  Future remove(ExpenseEntity entity) async {
    return database.expense.deleteWhere((tbl) => tbl.id.isValue(entity.id));
  }

  Future<List<ExpenseEntity>> allExpenses() async {
    final expenses = await database.select(database.expense).get();

    return expenses
        .map((e) => ExpenseEntity(
              id: e.id,
              description: e.description,
              amount: e.amount,
              type: e.type,
              dateTime: e.date,
            ))
        .toList();
  }

  // get all expenses before today date
  Future<List<ExpenseEntity>> allExpensesBeforeToday() async {
    // var query = database.select(database.expense)
    //   ..where(
    //     (tbl) => Variable(
    //       tbl.date.month == Variable(DateTime.now().month) &&
    //           tbl.date.year == Variable(DateTime.now().year),
    //     ),
    //   );

    var customQuery = database.customSelect(
      'SELECT * FROM expense WHERE date < ${DateTime.now().microsecondsSinceEpoch.toString().substring(0, 10)}',
    );

    final expenses = await customQuery.get();

    return expenses.map((e) {
      return ExpenseEntity.fromMap(e.data);
    }).toList();
  }

  Stream<List<QueryRow>> stream() {
    var customQuery = database.customSelect(
      'SELECT * FROM expense WHERE date < ${DateTime.now().microsecondsSinceEpoch.toString().substring(0, 10)}',
    );

    // var query = database.select(database.expense);
    return customQuery.watch();
  }
}
