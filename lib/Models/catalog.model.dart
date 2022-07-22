import 'cartItem.model.dart';

class CatalogModel {
  static List<String> itemNames = ['a', 'b', 'c'];

  /// Get item by [id].
  ///
  /// In this sample, the catalog is infinite, looping over [itemNames].
  CartItemModel getById(int id) =>
      CartItemModel(id, itemNames[id % itemNames.length]);

  /// Get item by its position in the catalog.
  CartItemModel getByPosition(int position) {
    // In this simplified case, an item's position in the catalog
    // is also its id.
    return getById(position);
  }

  int get length => itemNames.length;
}
