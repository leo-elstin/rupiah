import 'package:drift/drift.dart';

enum MFType { sip, lumpSum }

enum SipPeriod { daily, monthly, weekly, yearly }

class MutualFund extends Table {
  IntColumn get id => integer().autoIncrement()();

  IntColumn get fundId => integer()();

  TextColumn get name => text().nullable()();

  TextColumn get description => text().nullable()();

  RealColumn get amount => real()();

  TextColumn get type => textEnum<MFType>()();

  TextColumn get period => textEnum<SipPeriod>()();

  DateTimeColumn get investedDate => dateTime().nullable()();

  IntColumn get accountId => integer()();

  BoolColumn get isActive => boolean().withDefault(const Constant(true))();
}
