import 'package:drift/drift.dart';

class Emi extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  DateTimeColumn get endDate => dateTime().nullable()();
}
