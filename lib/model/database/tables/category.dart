import 'package:drift/drift.dart';

class CategoryDb extends Table {
  TextColumn get id => text()();

  TextColumn get categoryName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get colorCode => text().nullable()();

  TextColumn get iconCode => text().nullable()();
}
