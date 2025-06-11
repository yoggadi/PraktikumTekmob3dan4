import 'package:flutter/material.dart';
import '../models/shopping_item.dart';

class ShoppingListProvider with ChangeNotifier {
  final List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => _items;

  void addItem(String itemName) {
    _items.add(ShoppingItem(name: itemName));
    notifyListeners();
  }

  void toggleItem(int index) {
    _items[index].isBought = !_items[index].isBought;
    notifyListeners();
  }

  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }
}
