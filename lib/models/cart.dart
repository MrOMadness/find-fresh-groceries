import 'dart:collection';

import 'package:find_fresh_groceries/models/catalog.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  // final List<Catalog> _items = [];
  final List<Catalog> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Catalog> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart. This and [removeAll] are the only ways to modify the
  /// cart from the outside.
  void add(Catalog item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void removeAll() {
    _items.clear();
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  String count() {
    if (_items.length > 99) {
      return '99+';
    }
    return _items.length.toString();
  }
}
