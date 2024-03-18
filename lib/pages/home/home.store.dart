import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/category.model.dart';
import '../../repositories/category.repository.dart';

// Include generated file
part 'home.store.g.dart';

// This is the class used by rest of your codebase
class HomeStore = HomeStoreBase with _$HomeStore;

// The store-class
abstract class HomeStoreBase with Store {
  @observable
  ObservableList<Category> categories = <Category>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  Future<void> getCategories() async {
    isLoading = true;

    final repository = GetIt.I.get<CategoryRepository>();

    categories = (await repository.getAllCategories()).asObservable();

    isLoading = false;
  }

  @action
  Future<bool> removeCategory(String idCategory) async {
    final repository = GetIt.I.get<CategoryRepository>();
    repository.removeCategory(idCategory);
    categories.removeWhere((category) => category.id == idCategory);

    return true;
  }
}
