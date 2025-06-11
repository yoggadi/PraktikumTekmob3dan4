import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/shopping_list_provider.dart';

class ShoppingListPage extends StatelessWidget {
  const ShoppingListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final shoppingListProvider = Provider.of<ShoppingListProvider>(context);
    final TextEditingController itemController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Shopping List'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: itemController,
                    decoration: const InputDecoration(
                      labelText: 'Enter Item',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () {
                    if (itemController.text.isNotEmpty) {
                      shoppingListProvider.addItem(itemController.text);
                      itemController.clear();
                    }
                  },
                  child: const Text('Add'),
                )
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shoppingListProvider.items.length,
              itemBuilder: (context, index) {
                final item = shoppingListProvider.items[index];
                return ListTile(
                  leading: Checkbox(
                    value: item.isBought,
                    onChanged: (value) {
                      shoppingListProvider.toggleItem(index);
                    },
                  ),
                  title: Text(
                    item.name,
                    style: TextStyle(
                      decoration: item.isBought ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      shoppingListProvider.removeItem(index);
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
