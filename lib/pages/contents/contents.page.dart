import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../colors.dart';
import '../../models/category.model.dart';
import 'contents.store.dart';
import 'widgets/add_content/add_content.widget.dart';
import 'widgets/card_content/card_content.widget.dart';

class ContentsPage extends StatelessWidget {
  final Category category;
  final store = ContentsStore();
  ContentsPage({super.key, required this.category}) {
    store.getContents(category.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem-vindo a sua biblioteca"),
        backgroundColor: primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Conteúdos da categoria: ${category.name}",
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Observer(
                builder: (context) {
                  return store.isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : ListView.builder(
                          itemCount: store.contents.length,
                          itemBuilder: (context, index) {
                            final content = store.contents[index];
                            return Dismissible(
                              key: ValueKey(content.id),
                              direction: DismissDirection.endToStart,
                              confirmDismiss: (direction) async {
                                return store.removeContent(
                                  contentId: content.id,
                                  categoryId: category.id,
                                );
                              },
                              background: Center(
                                child: Container(
                                  padding: const EdgeInsets.all(20),
                                  color: Colors.red[100],
                                  child: const Align(
                                    alignment: Alignment.centerRight,
                                    child: CircularProgressIndicator(
                                      color: primaryColor,
                                    ),
                                  ),
                                ),
                              ),
                              child: CardContent(
                                content: content,
                                categoryId: category.id,
                              ),
                            );
                          },
                        );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final contentName = await showDialog<String>(
            context: context,
            builder: (_) => const AddContent(),
          );

          if (contentName != null) {
            store.addNewContent(
              contentName: contentName,
              categoryId: category.id,
            );
          }
        },
        icon: const Icon(Icons.add),
        label: const Text("Conteúdo"),
        backgroundColor: primaryColor.withOpacity(.7),
      ),
    );
  }
}
