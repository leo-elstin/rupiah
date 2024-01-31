import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/expense.dart';
import 'package:expense_kit/model/entity/account_entity.dart';

enum AccountType { savings, credit, loan }

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get accountName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get colorCode => text().nullable()();

  TextColumn get iconCode => text().nullable()();

  RealColumn get balance => real()();

  IntColumn get accountType => intEnum<AccountType>().withDefault(const Constant(0))();
}

class AccountTable {
  Future insert(AccountEntity entity) async {
    var companion = AccountCompanion.insert(
      description: Value(entity.description),
      accountName: entity.accountName ?? '',
      colorCode: Value(entity.colorCode),
      iconCode: Value(entity.iconCode),
      balance: entity.balance ?? 0.0,
      accountType: const Value(AccountType.savings),
    );
    return database.into(database.account).insert(companion);
  }

  Future remove(AccountEntity entity) async {
    return database.account.deleteWhere(
      (tbl) => tbl.id.isValue(entity.id!),
    );
  }

  Future<List<AccountEntity>> get() async {
    final emiList = await database.select(database.account).get();
    final expenseList = await ExpenseTable().allExpensesBeforeToday();

    List<AccountEntity> accountList = [];
    for (var e in emiList) {
      double balance = expenseList.fold(0.0, (previousValue, element) {
        if (element.accountId == e.id) {
          return previousValue + element.amount;
        }
        return previousValue;
      });
      accountList.add(AccountEntity(
        id: e.id,
        description: e.description ?? '',
        accountName: e.accountName,
        colorCode: e.colorCode ?? '',
        iconCode: e.iconCode ?? '',
        balance: balance,
      ));
    }

    return accountList;
  }
}
