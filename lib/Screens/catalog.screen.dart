import 'package:flutter/material.dart';
import 'package:flutter_one/Models/cartItem.model.dart';
import 'package:provider/provider.dart';

import '../Models/cart.model.dart';
import '../Models/catalog.model.dart';
import '../Widgets/header.widget.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.
      body: CustomScrollView(
        slivers: [
          //_MyAppBar(),
          headerWidget(key: key, title: 'catalog'),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          // // Add the app bar to the CustomScrollView.
          // const SliverAppBar(
          //   // Provide a standard title.
          //   title: Text('MaterialApp - title'),
          //   // Allows the user to reveal the app bar if they begin scrolling
          //   // back up the list of items.
          //   floating: true,
          //   // Display a placeholder widget to visualize the shrinking size.
          //   flexibleSpace: Placeholder(),
          //   // Make the initial height of the SliverAppBar larger than normal.
          //   expandedHeight: 200,
          // ),
          // Next, create a SliverList
          SliverList(
            delegate: SliverChildBuilderDelegate(
                (context, index) => _MyListItem(index),
                childCount: context.read<CatalogModel>().length),
          ),
          // SliverList(
          //   // Use a delegate to build items as they're scrolled on screen.
          //   delegate: SliverChildBuilderDelegate(
          //     // The builder function returns a ListTile with a title that
          //     // displays the index of the current item.
          //     (context, index) => ListTile(title: Text('Item #$index')),
          //     // Builds 1000 ListTiles
          //     childCount: 1000,
          //   ),
          // ),
        ],
      ),
    );
  }
}

class _MyAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      title: Text('Catalog', style: Theme.of(context).textTheme.headline3),
      floating: true,
      backgroundColor: Colors.yellow,
      // flexibleSpace: Placeholder(),
      // //   // Make the initial height of the SliverAppBar larger than normal.
      // expandedHeight: 200,
      actions: [
        IconButton(
          icon: const Icon(Icons.shopping_cart),
          onPressed: () => Navigator.pushNamed(context, '/cart'),
        ),
      ],
    );
  }
}

class _MyListItem extends StatelessWidget {
  final int index;

  const _MyListItem(this.index);

  @override
  Widget build(BuildContext context) {
    var item = context.select<CatalogModel, CartItemModel>(
      // Here, we are only interested in the item at [index]. We don't care
      // about any other change.
      (catalog) => catalog.getByPosition(index),
    );
    // debugPrint('$index');

    var textTheme = Theme.of(context).textTheme.headline6;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: LimitedBox(
        maxHeight: 48,
        child: Row(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(color: item.color),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Text(item.name, style: textTheme),
            ),
            const SizedBox(width: 24),
            _AddButton(item: item),
          ],
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  final CartItemModel item;

  const _AddButton({required this.item});

  @override
  Widget build(BuildContext context) {
    // The context.select() method will let you listen to changes to
    // a *part* of a model. You define a function that "selects" (i.e. returns)
    // the part you're interested in, and the provider package will not rebuild
    // this widget unless that particular part of the model changes.
    //
    // This can lead to significant performance improvements.
    var isInCart = context.select<CartModel, bool>(
      // Here, we are only interested whether [item] is inside the cart.
      (cart) => cart.items.contains(item),
    );

    return TextButton(
      onPressed: isInCart
          ? () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var cart = context.read<CartModel>();
              cart.remove(item);
            }
          : () {
              // If the item is not in cart, we let the user add it.
              // We are using context.read() here because the callback
              // is executed whenever the user taps the button. In other
              // words, it is executed outside the build method.
              var cart = context.read<CartModel>();
              cart.add(item);
            },
      style: ButtonStyle(
        overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
          if (states.contains(MaterialState.pressed)) {
            return Theme.of(context).primaryColor;
          }
          return null; // Defer to the widget's default.
        }),
      ),
      child: isInCart
          ? const Icon(Icons.check, semanticLabel: 'ADDED')
          : const Text('ADD'),
    );
  }
}
