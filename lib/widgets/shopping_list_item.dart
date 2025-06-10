import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shopping_list_model.dart';

class ShoppingListItem extends StatelessWidget {
  final int index;

  const ShoppingListItem({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final item = context.select<ShoppingListModel, ShoppingItem>((model) => model.items[index]);

    return ListTile(
      title: Text(
        item.name,
        style: TextStyle(
          decoration: item.purchased ? TextDecoration.lineThrough : null,
        ),
      ),
      leading: Checkbox(
        value: item.purchased,
        onChanged: (_) {
          context.read<ShoppingListModel>().togglePurchased(index);
        },
      ),
      trailing: Wrap(
        spacing: 8,
        children: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              _editItemDialog(context, index, item.name);
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              context.read<ShoppingListModel>().removeItem(index);
            },
          ),
        ],
      ),
    );
  }

  void _editItemDialog(BuildContext context, int index, String currentName) {
    final TextEditingController controller = TextEditingController(text: currentName);

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Edit Item'),
        content: TextField(
          controller: controller,
          autofocus: true,
        ),
        actions: [
          TextButton(
            child: const Text('Batal'),
            onPressed: () => Navigator.of(context).pop(),
          ),
          ElevatedButton(
            child: const Text('Simpan'),
            onPressed: () {
              context.read<ShoppingListModel>().editItem(index, controller.text);
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}