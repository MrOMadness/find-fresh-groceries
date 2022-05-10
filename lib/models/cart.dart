import 'dart:collection';

import 'package:find_fresh_groceries/models/catalog.dart';
import 'package:flutter/material.dart';

class CartModel extends ChangeNotifier {
  /// Internal, private state of the cart.
  // final List<Catalog> _items = [];
  final List<Catalog> _items = [];

  /// An unmodifiable view of the items in the cart.
  UnmodifiableListView<Catalog> get items => UnmodifiableListView(_items);

  /// Adds [item] to cart.
  /// cart from the outside.
  void add(Catalog item) {
    _items.add(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void deleteElement(String name) {
    _items.removeWhere((item) => item.name == name);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  void reduceElement(Catalog item) {
    _items.remove(item);
    // This call tells the widgets that are listening to this model to rebuild.
    notifyListeners();
  }

  /// Removes all items from the cart.
  void deleteAll() {
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

  Map countPerElement() {
    var map = {};

    for (var element in _items) {
      if (!map.containsKey(element)) {
        map[element] = 1;
      } else {
        map[element] += 1;
      }
    }
    return map;
  }
}
