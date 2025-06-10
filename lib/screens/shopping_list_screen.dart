import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shopping_list_model.dart';
import '../widgets/shopping_list_item.dart';

class ShoppingListScreen extends StatefulWidget {
  const ShoppingListScreen({Key? key}) : super(key: key);

  @override
  State<ShoppingListScreen> createState() => _ShoppingListScreenState();
}

class _ShoppingListScreenState extends State<ShoppingListScreen> {
  final TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final shoppingList = context.watch<ShoppingListModel>();

    return Scaffold(
      appBar: AppBar(title: const Text('Daftar Belanja')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(labelText: 'Item baru'),
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    context.read<ShoppingListModel>().addItem(_controller.text);
                    _controller.clear();
                  },
                  child: const Text('Tambah'),
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: shoppingList.items.length,
              itemBuilder: (context, index) {
                return ShoppingListItem(index: index);
              },
            ),
          ),
        ],
      ),
    );
  }
}