import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/entity/account_entity.dart';

class Account extends Table {
  TextColumn get id => text()();

  TextColumn get accountName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get colorCode => text().nullable()();

  TextColumn get iconCode => text().nullable()();

  RealColumn get balance => real()();
}

class AccountTable {
  Future insert(AccountEntity entity) async {
    var companion = AccountCompanion.insert(
      id: entity.id ?? '',
      description: Value(entity.description),
      accountName: entity.accountName ?? '',
      colorCode: Value(entity.colorCode),
      iconCode: Value(entity.iconCode),
      balance: entity.balance?.toDouble() ?? 0.0,
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

    return emiList
        .map((e) => AccountEntity(
              id: e.id,
              description: e.description ?? '',
              accountName: e.accountName,
              colorCode: e.colorCode ?? '',
              iconCode: e.iconCode ?? '',
              balance: e.balance,
            ))
        .toList();
  }
}
