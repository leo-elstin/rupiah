part of 'category_cubit.dart';

@immutable
abstract class CategoryState {}

class CategoryInitial extends CategoryState {}

class CategoryUpdated extends CategoryState {}

class CategoriesLoaded extends CategoryState {}
