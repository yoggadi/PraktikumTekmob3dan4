import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/shopping_list_model.dart';
import '../screens/product_detail_screen.dart';

class ECommerceScreen extends StatefulWidget {
  const ECommerceScreen({Key? key}) : super(key: key);

  @override
  State<ECommerceScreen> createState() => _ECommerceScreenState();
}

class _ECommerceScreenState extends State<ECommerceScreen> {
  String selectedCategory = 'Semua';

  final List<Map<String, String>> products = const [
    {
      'name': 'Nike Alphafly 3 Premium',
      'price': 'Rp 4.289.000',
      'image': 'assets/images/Nike Alphafly 3 Premium.jpg',
      'category': 'Outfit'
    },
    {
      'name': 'Nike ACG "DAYMAX"',
      'price': 'Rp 1.649.000',
      'image': 'assets/images/Nike ACG DAYMAX.jpg',
      'category': 'Outfit'
    },
    {
      'name': 'Rolex GMT Master II',
      'price': 'Rp 288.000.000',
      'image': 'assets/images/Rolex GMT Master II.png',
      'category': 'Aksesoris'
    },
    {
      'name': 'NIKE ISPA',
      'price': 'Rp 749.000',
      'image': 'assets/images/NIKE ISPA.jpg',
      'category': 'Outfit'
    },
    {
      'name': 'MacBook Pro (16 inch, M3 Pro)',
      'price': 'Rp 56.999.000',
      'image': 'assets/images/MacBook Pro (16 inch, M3 Pro).jpeg',
      'category': 'Elektronik'
    },
    {
      'name': 'SteelSeries Arctis Pro Wireless',
      'price': 'Rp 5.450.000',
      'image': 'assets/images/SteelSeries Arctis Pro Wireless.jpg',
      'category': 'Elektronik'
    },
    {
      'name': 'Coral Theatre Shirt',
      'price': 'Rp 19.050.000',
      'image': 'assets/images/Coral Theatre Shirt.jpg',
      'category': 'Outfit'
    },
    {
      'name': 'NextComputing Edge DL',
      'price': 'Rp 778.471.559',
      'image': 'assets/images/NextComputing Edge DL.jpg',
      'category': 'Elektronik'
    },
  ];

  final List<Map<String, dynamic>> categories = [
    {'name': 'Outfit', 'icon': Icons.shopping_bag},
    {'name': 'Aksesoris', 'icon': Icons.watch},
    {'name': 'Elektronik', 'icon': Icons.devices},
  ];

  @override
  Widget build(BuildContext context) {
    List<Map<String, String>> filteredProducts = selectedCategory == 'Semua'
        ? products
        : products.where((product) => product['category'] == selectedCategory).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Amajon Store'),
        actions: [
          IconButton(
            tooltip: 'Profil Pengguna',
            onPressed: () {
              Navigator.pushNamed(context, '/profile');
            },
            icon: const Icon(Icons.person),
          ),
          IconButton(
            tooltip: 'Daftar Belanja',
            onPressed: () {
              Navigator.pushNamed(context, '/shopping');
            },
            icon: const Icon(Icons.shopping_cart),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildCategoryFilter(),
            const SizedBox(height: 10),
            Expanded(
              child: LayoutBuilder(
                builder: (context, constraints) {
                  int crossAxisCount = 2;
                  if (constraints.maxWidth > 600) {
                    crossAxisCount = 3;
                  }
                  if (constraints.maxWidth > 900) {
                    crossAxisCount = 4;
                  }
                  return GridView.builder(
                    padding: const EdgeInsets.all(12.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: crossAxisCount,
                      crossAxisSpacing: 12,
                      mainAxisSpacing: 12,
                      childAspectRatio: 3 / 4,
                    ),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return _buildProductCard(context, filteredProducts[index]);
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryFilter() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
      child: Row(
        children: [
          _buildCategoryButton('Semua', Icons.list),
          const SizedBox(width: 12),
          ...categories.map((category) {
            return Padding(
              padding: const EdgeInsets.only(right: 12),
              child: _buildCategoryButton(category['name'], category['icon']),
            );
          }).toList(),
        ],
      ),
    );
  }

  Widget _buildCategoryButton(String category, IconData icon) {
    final bool isSelected = selectedCategory == category;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = category;
        });
      },
      child: Column(
        children: [
          Icon(
            icon,
            size: 30,
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          const SizedBox(height: 4),
          Text(
            category,
            style: TextStyle(
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
              color: isSelected ? Colors.blue : Colors.grey,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildProductCard(BuildContext context, Map<String, String> product) {
    return _HoverProductCard(product: product);
  }
}

class _HoverProductCard extends StatefulWidget {
  final Map<String, String> product;

  const _HoverProductCard({Key? key, required this.product}) : super(key: key);

  @override
  State<_HoverProductCard> createState() => _HoverProductCardState();
}

class _HoverProductCardState extends State<_HoverProductCard> {
  bool isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) {
        setState(() {
          isHovered = true;
        });
      },
      onExit: (_) {
        setState(() {
          isHovered = false;
        });
      },
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(product: widget.product),
            ),
          );
        },
        child: AnimatedScale(
          scale: isHovered ? 1.05 : 1.0,
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeInOut,
          child: Card(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: isHovered ? 8 : 4,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    flex: 6,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(8),
                      child: Image.network(
                        widget.product['image']!,
                        width: double.infinity,
                        fit: BoxFit.contain,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.product['name']!,
                          textAlign: TextAlign.center,
                          style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.product['price']!,
                          style: const TextStyle(fontSize: 11, color: Colors.blue),
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: () {
                            final String name = widget.product['name']!;
                            final String imagePath = widget.product['image']!;
                            final String rawPrice = widget.product['price']!;

                            // Konversi harga string "Rp 56.999.000" menjadi double 56999000.0
                            final double price = double.tryParse(
                              rawPrice.replaceAll('Rp', '').replaceAll('.', '').replaceAll(',', '').trim()
                            ) ?? 0.0;

                            context.read<ShoppingListModel>().addItem(name, imagePath, price);

                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text('$name ditambahkan ke keranjang')),
                            );
                          },
                          child: const Text('Beli', style: TextStyle(fontSize: 10)),
                          style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
