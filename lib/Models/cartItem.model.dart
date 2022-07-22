// class CartItemModel {
//   String title = '';
//   String description = '';
//   double price = 0;
// }

import 'package:flutter/material.dart';

@immutable
class CartItemModel {
  final int id;
  final String name;
  final Color color;
  final int price = 42;

  CartItemModel(this.id, this.name)
      // To make the sample app look nicer, each item is given one of the
      // Material Design primary colors.
      : color = Colors.primaries[id % Colors.primaries.length];

  @override
  int get hashCode => id;

  @override
  bool operator ==(Object other) => other is CartItemModel && other.id == id;
}
