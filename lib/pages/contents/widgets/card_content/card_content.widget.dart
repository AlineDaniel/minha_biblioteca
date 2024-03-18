import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../colors.dart';
import '../../../../models/content.model.dart';
import 'update_content.store.dart';

class CardContent extends StatelessWidget {
  final Content content;
  final String categoryId;
  final store = UpdateContentStore();

  CardContent({
    Key? key,
    required this.content,
    required this.categoryId,
  }) : super(key: key) {
    store.setIsChecked(content.isChecked);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      shadowColor: primaryColor,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              primaryColor.withOpacity(.7),
              secondaryColor.withOpacity(.7),
            ],
          ),
        ),
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Observer(builder: (_) {
              return store.isLoading
                  ? const LinearProgressIndicator(
                      color: Colors.white,
                    )
                  : const SizedBox();
            }),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(content.name),
                Observer(
                  builder: (context) {
                    return TextButton(
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100),
                        ),
                        foregroundColor: primaryColor,
                      ),
                      onPressed: store.isLoading
                          ? null
                          : () {
                              store.updateIsChecked(
                                categoryId: categoryId,
                                contentId: content.id,
                              );
                            },
                      child: store.isChecked
                          ? const Icon(
                              Icons.visibility,
                              color: Colors.green,
                            )
                          : const Icon(
                              Icons.visibility_off,
                              color: Colors.red,
                            ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
