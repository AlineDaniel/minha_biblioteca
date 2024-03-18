import 'dart:io';

import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../models/category.model.dart';
import '../../../../repositories/category.repository.dart';

// Include generated file
part 'add_category.store.g.dart';

// This is the class used by rest of your codebase
class AddCategoryStore = AddCategoryStoreBase with _$AddCategoryStore;

// The store-class
abstract class AddCategoryStoreBase with Store {
  @observable
  File? imageCategory;

  @observable
  bool isLoading = false;

  @action
  void setImage(File image) => imageCategory = image;

  @action
  void removeImage() => imageCategory = null;

  @action
  Future<void> addCategory(String nameCategory) async {
    isLoading = true;

    final repository = GetIt.I.get<CategoryRepository>();

    await repository.addNewCategory(
      Category(
        id: DateTime.now().millisecond.toString(),
        name: nameCategory,
        filePath: imageCategory != null ? imageCategory!.path : null,
      ),
    );

    isLoading = false;
  }
}
