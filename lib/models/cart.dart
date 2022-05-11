import 'dart:collection';

import 'package:find_fresh_groceries/models/catalog.dart';
import 'package:flutter/material.dart';

// cart model
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

  // reduce selected item by 1
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

  // count with limit of 99. if above 99 -> '99+'
  String countWithMax() {
    if (_items.length > 99) {
      return '99+';
    }
    return _items.length.toString();
  }

  // count without limit. can go above 99
  String countNoMax() {
    return _items.length.toString();
  }

  // count category
  Map countPerElement() {
    _items.sort((a, b) => a.name.compareTo(b.name));

    Map count = {};
    for (var i in _items) {
      count[i] = (count[i] ?? 0) + 1;
    }

    return count;
  }

  // count total price
  double totalPrice() {
    double sum = 0;

    for (var element in _items) {
      sum += double.parse(element.price);
    }

    return sum;
  }
}
