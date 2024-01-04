import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/entity/expense_entity.dart';

class Expense extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  IntColumn get type => intEnum<ExpenseType>()();

  DateTimeColumn get date => dateTime().nullable()();

  IntColumn get accountId => integer()();

  IntColumn get categoryId => integer()();

  BoolColumn get isEMI => boolean().withDefault(const Constant(false))();

  IntColumn get emiId => integer().withDefault(const Constant(-1))();
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
      accountId: entity.accountId!,
      categoryId: entity.categoryId ?? 0,
    );
    return await database.into(database.expense).insert(companion);
  }

  Future update(ExpenseEntity entity) async {
    var companion = ExpenseCompanion.insert(
      id: Value(entity.id),
      description: Value(entity.description),
      amount: entity.amount,
      type: entity.type,
      date: Value(
        entity.dateTime ?? DateTime.now(),
      ),
      accountId: entity.accountId!,
      categoryId: entity.categoryId ?? 0,
    );
    return await database.expense.insertOnConflictUpdate(companion);
  }

  Future remove(ExpenseEntity entity) async {
    return database.expense.deleteWhere((tbl) => tbl.id.isValue(entity.id));
  }

  Future removeByEMI(int emiID) async {
    return database.expense.deleteWhere((tbl) => tbl.emiId.isValue(emiID));
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
              accountId: e.accountId,
              categoryId: e.categoryId,
            ))
        .toList();
  }

  // get all expenses before today date
  Future<List<ExpenseEntity>> allExpensesBeforeToday() async {
    var query = database.select(database.expense)
      ..where(
        (row) => row.date.isSmallerThanValue(DateTime.now()),
      );

    final expenses = await query.get();

    return expenses.map((e) {
      return ExpenseEntity.fromMap(e.toJson());
    }).toList();
  }

  MultiSelectable<ExpenseData> expenseStream() {
    return database.select(database.expense)
      ..where(
        (row) => row.date.isSmallerThanValue(DateTime.now()),
      );
  }
}
