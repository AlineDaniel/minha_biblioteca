import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';

import '../../models/content.model.dart';
import '../../repositories/content.repository.dart';

part 'contents.store.g.dart';

class ContentsStore = ContentsStoreBase with _$ContentsStore;

abstract class ContentsStoreBase with Store {
  @observable
  ObservableList<Content> contents = <Content>[].asObservable();

  @observable
  bool isLoading = false;

  @action
  Future<void> getContents(String categoryId) async {
    isLoading = true;

    final repository = GetIt.I.get<ContentRepository>();

    final contentsTemp = await repository.getAllContents(categoryId);

    contents = contentsTemp.asObservable();

    isLoading = false;
  }

  @action
  Future<void> addNewContent({
    required String contentName,
    required String categoryId,
  }) async {
    final repository = GetIt.I.get<ContentRepository>();
    final content = Content(
      id: DateTime.now().millisecond.toString(),
      name: contentName,
    );
    await repository.addNewContent(categoryId: categoryId, content: content);
    contents.add(content);
  }

  @action
  Future<bool> removeContent({
    required String contentId,
    required String categoryId,
  }) async {
    final repository = GetIt.I.get<ContentRepository>();
    await repository.removeContent(
      categoryId: categoryId,
      contentId: contentId,
    );
    contents.removeWhere((content) => content.id == contentId);
    return true;
  }
}
