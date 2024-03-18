import 'package:hive_flutter/hive_flutter.dart';

import '../models/category.model.dart';

class CategoryRepository {
  final Box<List> boxCategories;

  // injeção de dependencia
  CategoryRepository({required this.boxCategories});

  Future<List<Category>> getAllCategories() async {
    final categories = boxCategories.get("categories", defaultValue: [])!;
    await Future.delayed(const Duration(seconds: 1));
    return List<Category>.from(categories);
  }

  Future<void> addNewCategory(Category category) async {
    final categories = boxCategories.get("categories", defaultValue: [])!;
    categories.add(category);
    await boxCategories.put("categories", categories);
    await Future.delayed(const Duration(seconds: 2));
  }

  Future<void> removeCategory(String idCategory) async {
    final categories = await getAllCategories();
    categories.removeWhere((category) => category.id == idCategory);
    await boxCategories.put("categories", categories);
  }
}
