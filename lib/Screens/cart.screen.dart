import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_one/Models/cart.model.dart';
import 'package:provider/provider.dart';
import '../Widgets/header.widget.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cart = context.watch<CartModel>();
    return Scaffold(
      // No appbar provided to the Scaffold, only a body with a
      // CustomScrollView.

      body: CustomScrollView(
        slivers: [
          headerWidget(key: key, title: 'cart'),
          const SliverToBoxAdapter(child: SizedBox(height: 12)),
          SliverList(
            // Use a delegate to build items as they're scrolled on screen.
            delegate: SliverChildBuilderDelegate(
                // The builder function returns a ListTile with a title that
                // displays the index of the current item.
                (context, index) =>
                    ListTile(title: Text(cart.items[index].name)),
                // Builds 1000 ListTiles
                childCount: context.read<CartModel>().items.length),
          ),
        ],
      ),
    );
  }
}
