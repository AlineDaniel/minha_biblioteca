import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:get_it/get_it.dart';
import '../../colors.dart';
import 'home.store.dart';
import 'widgets/card_category/card_category.widget.dart';
import 'widgets/new_category/new_category.widget.dart';

class HomePage extends StatelessWidget {
  final store = HomeStore();

  HomePage({super.key}) {
    GetIt.I.allReady().then((_) => store.getCategories());
  }

  void newCategory(BuildContext ctx) async {
    await showModalBottomSheet(
      context: ctx,
      isScrollControlled: true,
      builder: (ctx) {
        return const NewCategory();
      },
    );

    store.getCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: const Text("Bem-vindo a sua biblioteca"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Escolha uma das categorias",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: secondaryColor,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Expanded(
              child: Observer(builder: (context) {
                return store.isLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: primaryColor,
                        ),
                      )
                    : ListView.builder(
                        itemCount: store.categories.length,
                        itemBuilder: (context, index) {
                          final category = store.categories[index];
                          return Dismissible(
                            key: ValueKey(category.id),
                            direction: DismissDirection.endToStart,
                            confirmDismiss: (direction) async {
                              return store.removeCategory(category.id);
                            },
                            background: Center(
                              child: Container(
                                height: 114,
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
                            child: CardCategory(category: category),
                          );
                        },
                      );
              }),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => newCategory(context),
        backgroundColor: primaryColor.withOpacity(.8),
        label: const Text("+ Categoria"),
      ),
    );
  }
}
