import 'package:flutter/material.dart';

class ShoppingItem {
  String name;
  String imagePath;
  double price;
  bool purchased;

  ShoppingItem({
    required this.name,
    required this.imagePath,
    required this.price,
    this.purchased = false,
  });
}

class ShoppingListModel extends ChangeNotifier {
  final List<ShoppingItem> _items = [];

  List<ShoppingItem> get items => List.unmodifiable(_items);

  // Menambahkan item ke dalam keranjang
  void addItem(String name, String imagePath, double price) {
    if (name.trim().isEmpty || imagePath.trim().isEmpty || price <= 0) return;
    _items.add(ShoppingItem(name: name, imagePath: imagePath, price: price));
    notifyListeners();
  }

  // Menghapus item dari keranjang
  void removeItem(int index) {
    _items.removeAt(index);
    notifyListeners();
  }

  // Mengubah status pembelian
  void togglePurchased(int index) {
    _items[index].purchased = !_items[index].purchased;
    notifyListeners();
  }

  // Mengedit item: nama dan harga produk
  void editItem(int index, String newName, double newPrice) {
    _items[index].name = newName;
    _items[index].price = newPrice;
    notifyListeners();
  }
}
