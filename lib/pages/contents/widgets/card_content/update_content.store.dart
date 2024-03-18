import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../../../repositories/content.repository.dart';

part 'update_content.store.g.dart';

class UpdateContentStore = UpdateContentStoreBase with _$UpdateContentStore;

abstract class UpdateContentStoreBase with Store {
  @observable
  bool isLoading = false;

  @observable
  bool isChecked = false;

  @action
  void setIsChecked(bool initialIsChecked) => isChecked = initialIsChecked;

  @action
  Future<void> updateIsChecked({
    required String categoryId,
    required String contentId,
  }) async {
    isLoading = true;

    final newIsChecked = !isChecked;

    final repository = GetIt.I.get<ContentRepository>();

    await repository.updateContent(
      categoryId: categoryId,
      contentId: contentId,
      isChecked: newIsChecked,
    );

    isChecked = newIsChecked;

    isLoading = false;
  }
}
