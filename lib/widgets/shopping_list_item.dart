import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shopping_list_model.dart';

class ShoppingListItem extends StatelessWidget {
  final int index;

  const ShoppingListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.watch<ShoppingListModel>();
    final item = context.select<ShoppingListModel, ShoppingItem>((model) => model.items[index]);

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      elevation: 3,
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Checkbox(
              value: item.purchased,
              onChanged: (_) {
                shoppingList.togglePurchased(index);
              },
            ),
            const SizedBox(width: 8.0),
            ClipRRect(
              borderRadius: BorderRadius.circular(8.0),
              child: Image.asset(
                item.imagePath, // Perbaikan disini, gunakan Image.asset
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
            ),
          ],
        ),
        title: Text(
          item.name,
          style: TextStyle(
            fontSize: 16,
            decoration: item.purchased ? TextDecoration.lineThrough : null,
            color: item.purchased ? Colors.grey : Colors.black,
          ),
        ),
        subtitle: Text(
          'Rp ${item.price.toStringAsFixed(0)}',
          style: const TextStyle(color: Colors.blue),
        ),
        trailing: Wrap(
          spacing: 8,
          children: [
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.orange),
              onPressed: () {
                _editItemDialog(context, index, item.name, item.price);
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                shoppingList.removeItem(index);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('${item.name} dihapus dari keranjang')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _editItemDialog(BuildContext context, int index, String currentName, double currentPrice) {
    final TextEditingController nameController = TextEditingController(text: currentName);
    final TextEditingController priceController = TextEditingController(text: currentPrice.toString());

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Produk'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              autofocus: true,
              decoration: const InputDecoration(labelText: 'Nama Produk'),
            ),
            TextField(
              controller: priceController,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(labelText: 'Harga Produk'),
            ),
          ],
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () {
              context.read<ShoppingListModel>().editItem(
                    index,
                    nameController.text,
                    double.tryParse(priceController.text) ?? currentPrice,
                  );
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}
