import 'package:drift/drift.dart';

class Account extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get accountName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get colorCode => text().nullable()();

  TextColumn get iconCode => text().nullable()();
}
