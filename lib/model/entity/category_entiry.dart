class CategoryEntity {
  final int id;
  final String name;
  final String? description;
  final String? colorCode;
  final String? iconCode;

  CategoryEntity({
    required this.id,
    required this.name,
    this.description,
    this.colorCode,
    this.iconCode,
  });
}
