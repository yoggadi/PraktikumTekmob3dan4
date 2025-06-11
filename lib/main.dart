import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'models/shopping_list_model.dart';
import 'screens/ecommerce_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/edit_profile_screen.dart';
import 'screens/shopping_list_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ShoppingListModel(),
      child: MaterialApp(
        title: 'Amajon Store',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          useMaterial3: true,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => const ECommerceScreen(),
          '/profile': (context) => const ProfileScreen(),
          '/edit': (context) => const EditProfileScreen(),
          '/shopping': (context) => const ShoppingListScreen(),
        },
      ),
    );
  }
}
