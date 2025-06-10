import 'package:flutter/material.dart';

class ShoppingItem {
  String name;
  bool purchased;
  ShoppingItem(this.name, {this.purchased = false});
}

class ShoppingListModel extends ChangeNotifier {
  final List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => List.unmodifiable(_items);

  void addItem(String name) {
    if (name.trim().isEmpty) return;
    _items.add(ShoppingItem(name));
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  void togglePurchased(int index) {
    _items[index].purchased = !_items[index].purchased;
    notifyListeners();
  }

  void editItem(int index, String newName) {
    _items[index].name = newName;
    notifyListeners();
  }
}