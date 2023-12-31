import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/entity/category_entiry.dart';

class CategoryDb extends Table {
  IntColumn get id => integer().autoIncrement()();

  TextColumn get categoryName => text()();

  TextColumn get description => text().nullable()();

  TextColumn get colorCode => text().nullable()();

  TextColumn get iconCode => text().nullable()();
}

class CategoryQuery {
  Future insert(CategoryDbCompanion companion) async {
    return database.into(database.categoryDb).insert(companion);
  }

  Future<List<CategoryEntity>> getAll() async {
    List<CategoryDbData> categories =
        await database.select(database.categoryDb).get();
    return categories
        .map((e) => CategoryEntity(
              id: e.id,
              name: e.categoryName,
              description: e.description,
              colorCode: e.colorCode,
              iconCode: e.iconCode,
            ))
        .toList();
  }
}
