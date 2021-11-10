import 'package:flutter/material.dart';
import 'package:untitled/screen/order_screen.dart';
import 'package:untitled/screen/user_product_screen.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          AppBar(
            title: const Text('Hello Friend'),
            automaticallyImplyLeading: false,
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, '/');
            },
            leading: const Icon(Icons.shop),
            title: const Text('Shop'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, OrderScreen.routeName);
            },
            leading: const Icon(Icons.payment),
            title: const Text('My Orders'),
          ),
          const Divider(),
          ListTile(
            onTap: () {
              Navigator.pushReplacementNamed(context, UserProductScreen.routeName);
            },
            leading: const Icon(Icons.edit),
            title: const Text('Manage Product'),
          ),
        ],
      ),
    );
  }
}
