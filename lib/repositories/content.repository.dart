import 'package:hive_flutter/hive_flutter.dart';

import '../models/content.model.dart';

class ContentRepository {
  final Box<List> _boxContents;

  ContentRepository({required Box<List> boxContents})
      : _boxContents = boxContents;

  /*
    contents:ID_CATEGORIA : [todas os conteudos daquela categoria]
  */

  Future<List<Content>> getAllContents(String categoryId) async {
    await Future.delayed(const Duration(seconds: 1));
    final contents = _boxContents.get("contents:$categoryId", defaultValue: []);
    return List<Content>.from(contents!);
  }

  Future<void> addNewContent({
    required String categoryId,
    required Content content,
  }) async {
    final contents = await getAllContents(categoryId);
    contents.add(content);
    await _boxContents.put("contents:$categoryId", contents);
  }

  Future<void> updateContent({
    required String categoryId,
    required String contentId,
    required bool isChecked,
  }) async {
    final contents = await getAllContents(categoryId);
    final indexContent =
        contents.indexWhere((content) => content.id == contentId);
    contents[indexContent] =
        contents[indexContent].copyWith(isChecked: isChecked);
    await _boxContents.put("contents:$categoryId", contents);
  }

  Future<void> removeContent({
    required String categoryId,
    required String contentId,
  }) async {
    final contents = await getAllContents(categoryId);
    contents.removeWhere((content) => content.id == contentId);
    await _boxContents.put("contents:$categoryId", contents);
  }
}
