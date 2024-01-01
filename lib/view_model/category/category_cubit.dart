import 'package:drift/drift.dart';
import 'package:expense_kit/model/database/database.dart';
import 'package:expense_kit/model/database/tables/category_table.dart';
import 'package:expense_kit/model/entity/category_entiry.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'category_state.dart';

class CategoryCubit extends Cubit<CategoryState> {
  CategoryCubit() : super(CategoryInitial());
  CategoryDbCompanion companion = const CategoryDbCompanion();

  List<CategoryEntity> _list = [];

  set list(List<CategoryEntity> value) {
    _list = value;
    emit(CategoriesLoaded());
  }

  List<CategoryEntity> get list => _list;

  final CategoryQuery _query = CategoryQuery();

  void reset() {
    companion = const CategoryDbCompanion();
    emit(CategoryInitial());
  }

  void iconUpdate(String iconCode) {
    companion = companion.copyWith(
      iconCode: Value(iconCode),
    );
    emit(CategoryUpdated());
  }

  void colorUpdate(String colorCode) {
    companion = companion.copyWith(
      colorCode: Value(colorCode),
    );
    emit(CategoryUpdated());
  }

  void nameUpdate(String name) {
    companion = companion.copyWith(
      categoryName: Value(name),
    );
    emit(CategoryUpdated());
  }

  void descriptionUpdate(String description) {
    companion = companion.copyWith(
      description: Value(description),
    );
    emit(CategoryUpdated());
  }

  bool get valid =>
      companion.categoryName.present && companion.categoryName.value.isNotEmpty;

  void create() async {
    await _query.insert(companion);
    reset();
    get();
  }

  void get() async {
    list = await _query.getAll();
  }
}
