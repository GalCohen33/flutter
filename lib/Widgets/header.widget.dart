import 'dart:developer';
import 'package:flutter/material.dart';

class headerWidget extends StatelessWidget {
  final title;

  const headerWidget({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
          child: Center(
              child:
                  Text(title, style: Theme.of(context).textTheme.headline3))),
      floating: false,
      backgroundColor: Color.fromARGB(255, 170, 154, 29),
      //flexibleSpace: Placeholder(),
      // Make the initial height of the SliverAppBar larger than normal.
      actions: [iconBtn(title: title)],
    );
  }
}

class iconBtn extends StatelessWidget {
  final title;

  const iconBtn({Key? key, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    debugPrint(title);
    switch (title) {
      case 'catalog':
        return IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        );
      case 'cart':
        return IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context));
      default:
        {
          return IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.pushNamed(context, '/cart'),
          );
        }
    }
  }
}
