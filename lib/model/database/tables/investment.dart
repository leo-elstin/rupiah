import 'package:drift/drift.dart';
import 'package:expense_kit/features/investment/model/investment_model.dart';

class Investment extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get description => text().nullable()();

  RealColumn get investedValue => real()();

  RealColumn get currentValue => real()();

  DateTimeColumn get investedDate => dateTime().nullable()();

  IntColumn get type => intEnum<InvestmentType>()();
}
