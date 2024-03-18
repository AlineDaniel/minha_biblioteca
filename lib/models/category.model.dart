import 'package:hive/hive.dart';

part 'category.model.g.dart';

@HiveType(typeId: 1)
class Category {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String? filePath;

  Category({
    required this.id,
    required this.name,
    this.filePath,
  });
}
